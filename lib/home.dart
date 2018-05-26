import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'add_or_edit_task.dart';
import 'task.dart';
import 'task_list_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Home")),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('tasks').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.data.documents.isEmpty) {
              return Center(
                  child: Text('You have no tasks, you can create '
                      'them tapping in the + button'));
            }
            return ListView(
              children: snapshot.data.documents.map((DocumentSnapshot d) {
                final Task task = Task(
                    d.documentID, d['title'], d['description'], DateTime.now(),
                    isCompleted: d['isCompleted'] ?? false);
                return TaskListItem(
                    task,
                    (checked) => onTaskStateChanged(task, checked),
                    () => onTaskClicked(task),
                    () => onRemoveTask(context, task));
              }).toList(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: () => onTaskClicked(null)));
  }

  void onTaskStateChanged(Task task, bool completed) {
    Firestore.instance.collection('tasks').document(task.taskId).setData({
      'title': task.title,
      'description': task.description,
      'updatedAt': task.updatedAt,
      'isCompleted': completed
    });
  }

  void onTaskClicked(Task task) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => AddOrEditTaskScreen(task: task)));
  }

  void onRemoveTask(BuildContext context, Task task) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete task?'),
            actions: <Widget>[
              FlatButton(
                child: Text('Yes'),
                onPressed: () {
                  Firestore.instance
                      .collection('tasks')
                      .document(task.taskId)
                      .delete()
                      .then((value) => Navigator.of(context).pop());
                },
              ),
              FlatButton(
                child: Text('No'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }
}
