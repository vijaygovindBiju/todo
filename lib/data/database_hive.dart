import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo/data/tasks.dart';
import 'package:todo/widget/dialogbo.dart';

class DatabaseHive {
  List<Tasks> tasks = [];

  var box = Hive.box<Tasks>("TaskBox");
  void saving(String task, bool isDone) {
    box.add(Tasks(text: task, isDone: isDone));
    tasks.add(Tasks(text: task, isDone: isDone));
  }

    void remove(int index) {
      tasks.removeAt(index);
    box.deleteAt(index);
  }


  void onChange(int index) {
      tasks[index].isDone = !tasks[index].isDone;
    box.putAt(
      index,
      Tasks(text: tasks[index].text, isDone: tasks[index].isDone),
    );
  }



    void editOrAdd(int? index,BuildContext context ) async {
    if (index != null) {
      final result = await showDialog(
        context: context,
        builder: (context) {
          return Dialogbo(index: index, task: tasks[index].text);
        },
      );
      if (result != null) {
          tasks[index].text = result;
        box.putAt(
          index,
          Tasks(text: tasks[index].text, isDone: tasks[index].isDone),
        );
      }
    } else {
      final result = await showDialog(
        context: context,
        builder: (context) {
          return Dialogbo(index: null, task: "");
        },
      );
      if (result != null) {
          saving(result.toString(), false);
      }
    }
  }




}
