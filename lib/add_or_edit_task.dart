import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'task.dart';
import 'tasks_db.dart';

class AddOrEditTaskScreen extends StatefulWidget {
  AddOrEditTaskScreen({this.task});

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
      appBar: AppBar(title: Text('New Task')),
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
      /*If we are editing, rather than changing passed Task's properties (the
       are immutable), just remove from DB and create a new one with the same
        taskId*/
      if (task != null) {
        TaskDb.tasks.remove(task);
      }
      final taskId = task != null ? task.taskId : Uuid().v4();
      TaskDb.tasks.add(Task(taskId, title, description, DateTime.now()));
      Navigator.of(context).pop();
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
