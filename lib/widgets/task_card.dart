import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  final bool isCompleted;
  final void Function(bool?) onMarked;
  final String taskTitle;
  final void Function(String) onTaskTitleChanged;
  final void Function() onDelete;

  const TaskCard({
    super.key,
    required this.isCompleted,
    required this.onMarked,
    required this.taskTitle,
    required this.onTaskTitleChanged,
    required this.onDelete,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _isEditing = false;
  late String _taskTitle;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.taskTitle);
    _taskTitle = widget.taskTitle;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startEditing() {
    setState(() {
      _isEditing = true;
    });
  }

  void _finishEditing() {
    _taskTitle = _controller.text.trim();
    setState(() {
      _isEditing = false;
    });
    widget.onTaskTitleChanged(_controller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFFFFFFF).withOpacity(0.3),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: widget.isCompleted,
                onChanged: widget.onMarked,
                shape: const CircleBorder(),
                side: const BorderSide(color: Colors.black, width: 1.5),
                activeColor: Colors.blue,
                checkColor: Colors.white,
              ),
              Expanded(
                child: _isEditing
                    ? TextField(
                        controller: _controller,
                        autofocus: true,
                        onSubmitted: (_) => _finishEditing(),
                        onEditingComplete: _finishEditing,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(color: Colors.black),
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue, width: 2),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey, width: 1),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: _startEditing,
                        child: Text(
                          _taskTitle,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(color: Colors.black),
                        ),
                      ),
              ),
              IconButton(
                onPressed: widget.onDelete,
                icon: const Icon(Icons.delete_outline),
              ),
            ],
          ),
          const Divider()
        ],
      ),
    );
  }
}
