import 'package:flutter/material.dart';
import 'package:todo/data/database_hive.dart';
import 'package:todo/widget/dialogbo.dart';
import 'package:todo/widget/todo_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseHive db = DatabaseHive();

  void editOrAdd(int? index) async {
    if (index != null) {
      final result = await showDialog(
        context: context,
        builder: (context) {
          return Dialogbo(index: index, task: db.tasks[index].text);
        },
      );
      if (result != null) {
        db.tasks[index].text = result;
        db.update(index);
      }
    } else {
      final result = await showDialog(
        context: context,
        builder: (context) {
          return Dialogbo(index: null, task: "");
        },
      );
      if (result != null) {
        db.saving(result.toString(), false);
      }
    }
  }

  @override
  void initState() {
    db.taskCalling;
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
          editOrAdd(null);
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
                  editOrAdd(index);
                }),
              );
            },
          ),
        ),
      ),
    );
  }
}
