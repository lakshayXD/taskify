import 'package:flutter/material.dart';
import 'package:todo_list/utils/constants.dart';

class NoItemWidget extends StatelessWidget {
  const NoItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            Icon(Icons.inbox_rounded, size: 72, color: Colors.grey.shade400),
            const SizedBox(height: 20),
            Text(
              noTaskYetText,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              addTaskText,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}
