import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/features/todo_list/task_model.dart';
import 'package:todo_list/utils/constants.dart';

///notifier provider for loading all task list from cache
final tasksListFetchNotifierProvider = StateNotifierProvider.autoDispose(
  (ref) => TaskListFetchNotifier(),
);

class TaskListFetchNotifier extends StateNotifier {
  TaskListFetchNotifier() : super(null);

  ///method for loading all the tasks from cache
  Future<void> fetchAllTaskList() async {
    try {
      state = null;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final taskJsonList = sharedPreferences.getStringList(taskListKey) ?? [];
      state = taskJsonList
          .map((json) => Task.fromMap(jsonDecode(json)))
          .toList();
    } on Exception catch (e) {
      state = e;
    } catch (e) {
      state = Exception(e.toString());
    }
  }

  ///method for loading active tasks from cache
  Future<void> fetchActiveTaskList() async {
    try {
      state = null;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final taskJsonList = sharedPreferences.getStringList(taskListKey) ?? [];
      List<Map<String, dynamic>> taskMapList = taskJsonList
          .map((json) => jsonDecode(json) as Map<String, dynamic>)
          .toList();
      List<Task> taskList = [];
      for (Map<String, dynamic> taskMap in taskMapList) {
        if (taskMap['isCompleted'] == false) {
          taskList.add(Task.fromMap(taskMap));
        }
      }
      state = taskList;
    } on Exception catch (e) {
      state = e;
    } catch (e) {
      state = Exception(e.toString());
    }
  }

  ///method for loading completed tasks from cache
  Future<void> fetchCompletedTaskList() async {
    try {
      state = null;
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final taskJsonList = sharedPreferences.getStringList(taskListKey) ?? [];
      List<Map<String, dynamic>> taskMapList = taskJsonList
          .map((json) => jsonDecode(json) as Map<String, dynamic>)
          .toList();
      List<Task> taskList = [];
      for (Map<String, dynamic> taskMap in taskMapList) {
        if (taskMap['isCompleted'] == true) {
          taskList.add(Task.fromMap(taskMap));
        }
      }
      state = taskList;
    } on Exception catch (e) {
      state = e;
    } catch (e) {
      state = Exception(e.toString());
    }
  }
}
