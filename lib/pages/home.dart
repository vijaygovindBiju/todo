import 'package:flutter/material.dart';
import 'package:todo/data/database_hive.dart';
import 'package:todo/data/tasks.dart';
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
        onPressed: () => setState(() {
          db.editOrAdd(null, context);
        }),
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          child: ListView.builder(
            itemCount: db.tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return TodoCard(
                onPress: () => setState(() {
                  db.remove(index);
                }),
                todoText: db.tasks[index].text,
                isDone: db.tasks[index].isDone,
                onChanged: (_) => setState(() {
                  db.onChange(index);
                }),
                onPressed: () => setState(() {
                  db.editOrAdd(index, context);
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
