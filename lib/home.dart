import 'package:flutter/material.dart';

import 'destinations.dart';
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
    return Scaffold(
        appBar: AppBar(title: Text("Home")),
        body: ListView(
            children: TaskDb.tasks.map((Task task) {
          return new TaskListItem(task, TaskDb.completedTasks[task] ?? false,
              () => handleOnTaskPressed(task));
        }).toList()),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(Destinations.newTask)));
  }

  void handleOnTaskPressed(Task task) {
    setState(() {
      bool isCompleted = TaskDb.completedTasks[task] ?? false;
      TaskDb.completedTasks[task] = !isCompleted;
    });
  }
}
