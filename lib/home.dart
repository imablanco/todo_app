import 'package:flutter/material.dart';

import 'add_or_edit_task.dart';
import 'task.dart';
import 'task_list_item.dart';
import 'tasks_db.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    /*Sort tasks before displaying them*/
    TaskDb.tasks.sort((t1, t2) => t2.creationDate.compareTo(t1.creationDate));

    return Scaffold(
        appBar: AppBar(title: Text("Home")),
        body: ListView(
            children: TaskDb.tasks.map((Task task) {
          return TaskListItem(
              task,
              TaskDb.completedTasks[task] ?? false,
              (checked) => onTaskStateChanged(task, checked),
              () => onTaskClicked(task));
        }).toList()),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: () => onTaskClicked(null)));
  }

  void onTaskStateChanged(Task task, bool completed) {
    setState(() {
      TaskDb.completedTasks[task] = completed;
    });
  }

  void onTaskClicked(Task task) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddOrEditTaskScreen(task: task)));
  }
}
