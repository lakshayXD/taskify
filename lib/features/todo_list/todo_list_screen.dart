import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/features/todo_list/task_model.dart';
import 'package:todo_list/utils/constants.dart';
import 'package:todo_list/widgets/custom_snack_bar.dart';
import 'package:todo_list/widgets/custom_textfield.dart';
import 'package:todo_list/widgets/exit_confirmation_dialog.dart';
import 'package:todo_list/widgets/no_item_widget.dart';
import 'package:todo_list/widgets/task_card.dart';
import 'package:todo_list/widgets/task_tab_bar.dart';

import 'fetch_tasks_provider.dart';

class TodoListScreen extends ConsumerStatefulWidget {
  TodoListScreen({super.key});

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends ConsumerState<TodoListScreen> {
  late final TextEditingController _addTaskFieldController;
  late final ScrollController _scrollController;

  ///maintains the tasks list
  final _taskListStateProvider = StateProvider<List<Task>>(
    (context) => <Task>[],
  );

  ///progress loader state provider
  final loadingStateProvider = StateProvider<bool>((ref) => false);

  int _currTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _addTaskFieldController = TextEditingController();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _setTabList(0);
    });
  }

  @override
  void dispose() {
    _addTaskFieldController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  ///method for building the exit confirmation alert dialog
  Future<void> _showExitConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ExitConfirmationDialog();
      },
    );
  }

  ///method for fetching all task list
  Future<List<Task>> _fetchAllTaskList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final taskJsonList = sharedPreferences.getStringList(taskListKey) ?? [];
    return taskJsonList.map((json) => Task.fromMap(jsonDecode(json))).toList();
  }

  ///method for getting the latest task id
  Future<int?> _getLatestTaskId() async {
    final List<Task> taskList = await _fetchAllTaskList();
    if (taskList.isEmpty) {
      return null;
    }
    return taskList.map((task) => task.id).reduce((a, b) => a > b ? a : b);
  }

  Future<void> _saveTasks(List<Task> tasks) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonList = tasks.map((task) => jsonEncode(task.toMap())).toList();
    await prefs.setStringList(taskListKey, jsonList);
  }

  ///method for adding task to the tasklist
  Future<void> _addNewTask() async {
    if (_addTaskFieldController.text.isNotEmpty) {
      List<Task> currentList = await _fetchAllTaskList();
      int? latestTaskId = await _getLatestTaskId();
      Task newTask = Task(
        id: (latestTaskId ?? 0) + 1,
        title: _addTaskFieldController.text.trim(),
        isCompleted: false,
      );
      final updatedList = [...currentList, newTask];

      await _saveTasks(updatedList);
      await _setTabList(_currTabIndex);
      showSuccessSnackBar(taskAddedText);
      _addTaskFieldController.clear();
    } else {
      showErrorSnackBar(inputValidTaskText);
    }
  }

  ///method for deleting task to the tasklist
  Future<void> _deleteTask(int id) async {
    List<Task> currentList = await _fetchAllTaskList();
    final updatedList = currentList.where((task) => task.id != id).toList();
    await _saveTasks(updatedList);
    await _setTabList(_currTabIndex);
    showSuccessSnackBar(taskDeletedText);
  }

  ///method for updating task to the tasklist
  Future<void> _updateTask(
    int id, {
    String? taskTitle,
    bool? isCompleted,
  }) async {
    List<Task> currentList = await _fetchAllTaskList();
    final updatedList = currentList.map((task) {
      if (task.id == id) {
        return task.copyWith(
          title: taskTitle ?? task.title,
          isCompleted: isCompleted ?? task.isCompleted,
        );
      }
      return task;
    }).toList();
    await _saveTasks(updatedList);
    await _setTabList(_currTabIndex);
    showSuccessSnackBar(taskUpdatedText);
  }

  ///method for handling the checkbox states of tasks
  Future<void> _checkboxStateHandler(int id, bool? value) async {
    if (value == null) return;

    final notifier = ref.read(_taskListStateProvider.notifier);
    final currentList = notifier.state;

    final updatedList = currentList.map((task) {
      if (task.id == id) {
        return task.copyWith(isCompleted: value);
      }
      return task;
    }).toList();

    notifier.state = updatedList;

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonList = updatedList
        .map((task) => jsonEncode(task.toMap()))
        .toList();
    await sharedPreferences.setStringList(taskListKey, jsonList);

    showSuccessSnackBar(value ? taskCompleteText : taskIncompleteText);
  }

  ///method for generating lists according to tabs
  Future<void> _setTabList(int tabIndex) async {
    ref.read(loadingStateProvider.notifier).update((state) => true);
    try {
      if (tabIndex == 0) {
        ref.read(tasksListFetchNotifierProvider.notifier).fetchAllTaskList();
      } else if (tabIndex == 1) {
        ref.read(tasksListFetchNotifierProvider.notifier).fetchActiveTaskList();
      } else if (tabIndex == 2) {
        ref
            .read(tasksListFetchNotifierProvider.notifier)
            .fetchCompletedTaskList();
      }
    } catch (e) {
      showErrorSnackBar(somethingWentWrongText);
    }
    ref.read(loadingStateProvider.notifier).update((state) => false);
  }

  @override
  Widget build(BuildContext context) {
    List<Task> taskListState = ref.watch(_taskListStateProvider);

    ref.listen(tasksListFetchNotifierProvider, (previous, res) async {
      if (res != null) {
        if (res is List<Task>) {
          ref.read(_taskListStateProvider.notifier).state = res;
        } else if (res is Exception) {
          showErrorSnackBar(somethingWentWrongText);
        }
      }
    });

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (isPop, val) async {
        await _showExitConfirmationDialog(context);
      },
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(flex: 1, child: Container(color: primaryBlue)),
                const Expanded(flex: 2, child: SizedBox()),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        taskifyText,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: primaryWhite,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: primaryWhite,
                      ),
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: _addTaskFieldController,
                            onTaskAdded: () async {
                              try {
                                await _addNewTask();
                              } catch (e) {
                                showErrorSnackBar(somethingWentWrongText);
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          TaskTabBar(
                            onTabChanged: (int index) async {
                              _currTabIndex = index;
                              await _setTabList(index);
                            },
                          ),
                          const SizedBox(height: 15),
                          const Divider(),

                          if (taskListState.isNotEmpty)
                            Expanded(
                              child: AnimationLimiter(
                                child: Scrollbar(
                                  controller: _scrollController,
                                  thickness: 2,
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    controller: _scrollController,
                                    itemCount: taskListState.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      final task = taskListState[index];
                                      return KeyedSubtree(
                                        key: ValueKey(task.id),
                                        child:
                                            AnimationConfiguration.staggeredList(
                                              position: index,
                                              duration: const Duration(
                                                milliseconds: 375,
                                              ),
                                              child: SlideAnimation(
                                                verticalOffset: 50.0,
                                                child: FadeInAnimation(
                                                  child: Column(
                                                    children: [
                                                      if (index !=
                                                          taskListState.length -
                                                              1)
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                      TaskCard(
                                                        isCompleted:
                                                            task.isCompleted,
                                                        onMarked: (value) =>
                                                            _checkboxStateHandler(
                                                              task.id,
                                                              value,
                                                            ),
                                                        taskTitle: task.title,
                                                        onTaskTitleChanged:
                                                            (title) =>
                                                                _updateTask(
                                                                  task.id,
                                                                  taskTitle:
                                                                      title,
                                                                ),
                                                        onDelete: () =>
                                                            _deleteTask(
                                                              task.id,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          if (taskListState.isEmpty) NoItemWidget(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (ref.watch(loadingStateProvider)) ...[
              ModalBarrier(
                color: Colors.black.withOpacity(0.5),
                dismissible: false,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator(strokeWidth: 3),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
