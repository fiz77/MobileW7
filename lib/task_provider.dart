import 'package:flutter/material.dart';

class TaskProvider extends ChangeNotifier {
  final List<String> _tasks = [];

  List<String> get tasks => _tasks;

  void addTask(String task) {
    if (task.trim().isEmpty) return;
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }

  void editTask(int index, String newTask) {
    if (newTask.trim().isEmpty) return;
    _tasks[index] = newTask;
    notifyListeners();
  }
}
