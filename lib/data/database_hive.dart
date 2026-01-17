import 'package:hive_flutter/adapters.dart';
import 'package:todo/data/tasks.dart';

class DatabaseHive {
  List<Tasks> tasks = [];

  var box = Hive.box<Tasks>("TaskBox");
  void saving(String task, bool isDone) {
    box.add(Tasks(text: task, isDone: isDone));
    tasks.add(Tasks(text: task, isDone: isDone));
  }
}
