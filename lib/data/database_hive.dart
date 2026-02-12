import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/data/tasks.dart';

class DatabaseHive extends ChangeNotifier {
  List<Tasks> _tasks = [];

  var _box = Hive.box<Tasks>("TaskBox");

 List<Tasks> getTasks()=> _tasks;

  void taskCalling() {
    _tasks = _box.values.toList();
    notifyListeners();
  }

  void saving(String task, bool isDone) {
    _box.add(Tasks(text: task, isDone: isDone));
    taskCalling();
  }

  void remove(int index) {
    _box.deleteAt(index);
    taskCalling();
  }

  void onChange(int index, String text, bool isDone) {
    _box.putAt(index, Tasks(text: text, isDone: !isDone));
    taskCalling();
  }

  void update(int index, String text, bool isDone) {
    _box.putAt(index, Tasks(text: text, isDone: isDone));
    taskCalling();
  }
}
