import 'package:flutter/material.dart';
import 'package:todo/data/database_hive.dart';
import 'package:todo/data/tasks.dart';
import 'package:todo/widget/dialogbo.dart';
import 'package:todo/widget/todo_card.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHive db = DatabaseHive();
  var box = Hive.box<Tasks>("TaskBox");

  void editOrAdd(int? index) async {
    if (index != null) {
      final result = await showDialog(
        context: context,
        builder: (context) {
          return Dialogbo(index: index, task: db.tasks[index].text);
        },
      );
      if (result != null) {
        setState(() {
          db.tasks[index].text = result;
        });
        box.putAt(
          index,
          Tasks(text: db.tasks[index].text, isDone: db.tasks[index].isDone),
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
        setState(() {
          db.saving(result.toString(), false);
        });
      }
    }
  }

  void remove(int index) {
    setState(() {
      db.tasks.removeAt(index);
    });
    box.deleteAt(index);
  }

  void onChange(int index) {
    setState(() {
      db.tasks[index].isDone = !db.tasks[index].isDone;
    });
    box.putAt(
      index,
      Tasks(text: db.tasks[index].text, isDone: db.tasks[index].isDone),
    );
  }

  @override
  void initState() {
    db.tasks = box.values.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text("ToDo App"),
        centerTitle: true,
        backgroundColor: Colors.yellow[400],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => editOrAdd(null),
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          child: ListView.builder(
            itemCount: db.tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return TodoCard(
                onPress: () => remove(index),
                todoText: db.tasks[index].text,
                isDone: db.tasks[index].isDone,
                onChanged: (_) => onChange(index),
                onPressed: () => editOrAdd(index),
              );
            },
          ),
        ),
      ),
    );
  }
}
