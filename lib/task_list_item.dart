import 'package:flutter/material.dart';

import 'task.dart';

class TaskListItem extends StatelessWidget {
  TaskListItem(this.task, this.isCompleted, this.onChanged, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Row(
          children: <Widget>[
            Checkbox(
              value: isCompleted,
              onChanged: onChanged,
            ),
            Text(task.title)
          ],
        ));
  }

  final Task task;
  final ValueChanged<bool> onChanged;
  final VoidCallback onTap;
  final bool isCompleted;
}
