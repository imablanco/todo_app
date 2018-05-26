class Task {
  String taskId;
  String title;
  String description;
  DateTime updatedAt;
  bool isCompleted;

  Task(this.taskId, this.title, this.description, this.updatedAt,
      {this.isCompleted = false});
}
