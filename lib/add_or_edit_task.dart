import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'task.dart';

class AddOrEditTaskScreen extends StatefulWidget {
  AddOrEditTaskScreen({Key key, this.task}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AddOrEditTaskScreenState(task);

  final Task task;
}

class AddOrEditTaskScreenState extends State<AddOrEditTaskScreen> {
  AddOrEditTaskScreenState(this.task);

  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(task != null ? 'Edit Task ' : 'New Task')),
      body: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    initialValue: task != null ? task.title : null,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Title'),
                    validator: validateNonNull,
                    onSaved: onTaskTitleChanged,
                    onFieldSubmitted: (String text) {
                      FocusScope.of(context).requestFocus(textSecondFocusNode);
                    },
                  ),
                  TextFormField(
                    initialValue: task != null ? task.description : null,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Description'),
                    validator: validateNonNull,
                    onSaved: onTaskDescriptionChanged,
                    focusNode: textSecondFocusNode,
                  )
                ],
              ))),
      floatingActionButton: FloatingActionButton(
        onPressed: onSaveTask,
        child: Icon(Icons.check),
      ),
    );
  }

  String validateNonNull(String text) {
    if (text == null || text.isEmpty) {
      return 'Field can not be empty';
    }
    return null;
  }

  void onSaveTask() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      Task newTask;
      if (task != null) {
        task.title = title;
        task.description = description;
        task.updatedAt = DateTime.now();
        newTask = task;
      } else {
        newTask = Task(Uuid().v4(), title, description, DateTime.now());
      }

      Firestore.instance.collection('tasks').document(newTask.taskId).setData({
        'title': newTask.title,
        'description': newTask.description,
        'updatedAt': newTask.updatedAt,
        'isCompleted': newTask.isCompleted
      }).then((value) => Navigator.of(context).pop());
    }
  }

  void onTaskTitleChanged(String title) {
    this.title = title;
  }

  void onTaskDescriptionChanged(String description) {
    this.description = description;
  }

  final FocusNode textSecondFocusNode = new FocusNode();

  String title;
  String description;

  final Task task;
}
