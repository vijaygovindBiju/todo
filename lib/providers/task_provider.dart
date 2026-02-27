import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/data/models/task.dart';

class DatabaseHive extends ChangeNotifier {
  DatabaseHive() {
    _taskList = _box.values.toList();
  }
  List<Task> _taskList = [];

  var _box = Hive.box<Task>("TaskBox");

  List<Task> getTasks() => _taskList;

  void saving(String task, bool isDone) {
    _box.add(Task(text: task, isDone: isDone));
    _taskList.insert(0, Task(text: task, isDone: isDone));
    notifyListeners();
  }

  void remove(int index) {
    _box.deleteAt(index);
    _taskList.removeAt(index);
    notifyListeners();
  }

  void onChange(int index, String text, bool isDone) {
    _box.putAt(index, Task(text: text, isDone: isDone));
    _taskList[index].isDone = isDone;
    notifyListeners();
  }

  void update(int index, String text, bool isDone) {
    _box.putAt(index, Task(text: text, isDone: isDone));
    _taskList[index].text = text;
    _taskList[index].isDone = isDone;
    notifyListeners();
  }
}
