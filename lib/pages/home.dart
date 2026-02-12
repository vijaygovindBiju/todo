import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
        context.read<DatabaseHive>().update(index);
      }
    } else {
      final result = await showDialog(
        context: context,
        builder: (context) {
          return Dialogbo(index: null, task: "");
        },
      );
      if (result != null) {
        context.read<DatabaseHive>().saving(result.toString(), false);
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
        onPressed: () => editOrAdd(null),
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Consumer<DatabaseHive>(
          builder: (_, provider, _) => Container(
            child: ListView.builder(
              itemCount: provider.tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return TodoCard(
                  onPress: () => {context.read<DatabaseHive>().remove(index)},
                  todoText: provider.tasks[index].text,
                  isDone: provider.tasks[index].isDone,
                  onChanged: (_) {
                    context.read<DatabaseHive>().onChange(index);
                  },
                  onPressed: () => setState(() {
                    editOrAdd(index);
                  }),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
