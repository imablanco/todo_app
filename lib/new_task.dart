import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'task.dart';
import 'tasks_db.dart';

class NewTaskScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewTaskScreenState();
}

class NewTaskScreenState extends State<NewTaskScreen> {
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
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: 'Title'),
                    validator: validateNonNull,
                    onSaved: onTaskTitleChanged,
                    onFieldSubmitted: (String text) {
                      FocusScope.of(context).requestFocus(textSecondFocusNode);
                    },
                  ),
                  TextFormField(
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
      TaskDb.tasks.add(Task(Uuid().v4(), title, description));
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
}
