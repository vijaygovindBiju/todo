import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/data/models/task.dart';

class DatabaseHive extends ChangeNotifier {
  var _box = Hive.box<Task>("TaskBox");

  List<Task> getTasks() => _box.values.toList();

  void saving(String task, bool isDone) {
    _box.add(Task(text: task, isDone: isDone));
    notifyListeners();
  }

  void remove(int index) {
    _box.deleteAt(index);
    notifyListeners();
  }

  void onChange(int index, String text, bool isDone) {
    _box.putAt(index, Task(text: text, isDone: !isDone));
    notifyListeners();
  }

  void update(int index, String text, bool isDone) {
    _box.putAt(index, Task(text: text, isDone: isDone));
    notifyListeners();
  }
}
