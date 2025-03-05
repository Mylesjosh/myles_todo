import 'package:flutter/material.dart';

import 'package:myles_todo/models/task.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class SaveTask extends ChangeNotifier {
  SaveTask() {
    loadTasks();
  }
  final _box = Hive.box('mybox');

  List<Task> _tasks = [
    //Task(title: 'read', isCompleted: false)
  ];
  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    tasks.add(task);
    notifyListeners();
  }

  void removeTask(Task task) {
    tasks.remove(task);
    notifyListeners();
  }

  void checkTask(int index) {
    tasks[index].isDone();
    notifyListeners();
  }

  //Hive functions

  //load tasks from hive
  //creates the box("TASKS") if it doesn't exist
  void loadTasks() {
    //retrieve tasks from hive and convert to list of tasks
    final loadedTasks = _box.get("TASKS") as List<dynamic>? ??
        []; // if null, assign an empty list
    _tasks = loadedTasks
        .map((task) => Task.fromJson(Map<String, dynamic>.from(
            task))) // Explicitly cast to Map<String, dynamic>
        .toList();
  }

  //update tasks in hive
  void updateTasks() {
    //convert to list of maps
    _box.put("TASKS", tasks.map((task) => task.toJson()).toList());
  }
}
