import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/data/tasks.dart';

class DatabaseHive extends ChangeNotifier {
  var _box = Hive.box<Tasks>("TaskBox");

  List<Tasks> getTasks() => _box.values.toList();

  void saving(String task, bool isDone) {
    _box.add(Tasks(text: task, isDone: isDone));
    notifyListeners();
  }

  void remove(int index) {
    _box.deleteAt(index);
    notifyListeners();
  }

  void onChange(int index, String text, bool isDone) {
    _box.putAt(index, Tasks(text: text, isDone: !isDone));
    notifyListeners();
  }

  void update(int index, String text, bool isDone) {
    _box.putAt(index, Tasks(text: text, isDone: isDone));
    notifyListeners();
  }
}
