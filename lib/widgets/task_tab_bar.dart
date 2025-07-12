import 'package:flutter/material.dart';
import 'package:todo_list/utils/constants.dart';

class TaskTabBar extends StatefulWidget {
  final Function(int index)? onTabChanged;

  const TaskTabBar({super.key, required this.onTabChanged});

  @override
  State<TaskTabBar> createState() => _TaskTabBarState();
}

class _TaskTabBarState extends State<TaskTabBar> {
  final List<String> tabs = ['All', 'Active', 'Completed'];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: primaryWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tabWidth = constraints.maxWidth / tabs.length;

          return Stack(
            children: [
              AnimatedPositioned(
                left: selectedIndex * tabWidth,
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                child: Container(
                  width: tabWidth,
                  height: 32,
                  decoration: BoxDecoration(
                    color: primaryBlue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
              Row(
                children: List.generate(tabs.length, (index) {
                  final isSelected = index == selectedIndex;

                  return Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        setState(() => selectedIndex = index);
                        widget.onTabChanged?.call(index);
                      },
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(
                                color: isSelected
                                    ? primaryBlue
                                    : Colors.black.withOpacity(0.5),
                              ),
                          child: Text(tabs[index]),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
