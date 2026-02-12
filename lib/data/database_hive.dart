import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/data/tasks.dart';

class DatabaseHive extends ChangeNotifier {
  List<Tasks> tasks = [];

  var box = Hive.box<Tasks>("TaskBox");

  void taskCalling() {
    tasks = box.values.toList();
    notifyListeners();
  }

  void saving(String task, bool isDone) {
    box.add(Tasks(text: task, isDone: isDone));
    taskCalling();
  }

  void remove(int index) {
    box.deleteAt(index);
    taskCalling();
  }

  void onChange(int index, String text, bool isDone) {
    box.putAt(index, Tasks(text: text, isDone: !isDone));
    taskCalling();
  }

  void update(int index, String text, bool isDone) {
    box.putAt(index, Tasks(text: text, isDone: isDone));
    taskCalling();
  }
}
