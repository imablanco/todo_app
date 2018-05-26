import 'package:flutter/material.dart';

import 'task.dart';

class TaskListItem extends StatelessWidget {
  TaskListItem(this.task, this.onChanged, this.onTap, this.onLongPress);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Row(
          children: <Widget>[
            Checkbox(
              value: task.isCompleted,
              onChanged: onChanged,
            ),
            Flexible(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  task.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  task.description,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ))
          ],
        ));
  }

  final Task task;
  final ValueChanged<bool> onChanged;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
}
