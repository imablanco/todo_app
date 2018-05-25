import 'package:flutter/material.dart';
import 'task.dart';

class TaskListItem extends StatelessWidget {

  TaskListItem(this.task, this.isCompleted, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,
      leading: new Icon(getIcon()),
      title: new Text(task.title),
    );
  }

  IconData getIcon() {
    return isCompleted ? Icons.check_box : Icons.check_box_outline_blank;
  }

  final Task task;
  final VoidCallback onPressed;
  final bool isCompleted;
}