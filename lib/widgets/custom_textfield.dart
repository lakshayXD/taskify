import 'package:flutter/material.dart';
import 'package:todo_list/utils/constants.dart';

class CustomTextField extends StatelessWidget {
  final void Function() onTaskAdded;
  final TextEditingController controller;

  const CustomTextField(
      {super.key, required this.onTaskAdded, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: addTaskHintText,
                hintStyle: TextStyle(color: Colors.grey),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
              ),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              cursorColor: primaryBlue,
              onSubmitted: (value) => onTaskAdded(),
            )
          ),
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: primaryBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.add, color: primaryWhite, size: 20),
              onPressed: onTaskAdded,
            ),
          ),
        ],
      ),
    );
  }
}
