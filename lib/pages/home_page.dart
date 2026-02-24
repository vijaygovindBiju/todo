import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/widget/task_dialog.dart';
import 'package:todo/widget/todo_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  void editOrAdd(int? index) async {
    final taskProvider = context.read<DatabaseHive>();
    if (index != null) {
      final result = await showDialog(
        context: context,
        builder: (context) {
          return Dialogbo(
            index: index,
            task: taskProvider.getTasks()[index].text,
          );
        },
      );
      if (result != null) {
        taskProvider.update(
          index,
          result.toString(),
          taskProvider.getTasks()[index].isDone,
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
        taskProvider.saving(result.toString(), false);
      }
    }
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
          builder: (_, provider, _) {
            final List tasks = provider.getTasks();
            return Container(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  final task = tasks[index];
                  return TodoCard(
                    onPress: () => provider.remove(index),
                    todoText: task.text,
                    isDone: task.isDone,
                    onChanged: (_) {
                      provider.onChange(
                        index,
                        task.text,
                        task.isDone,
                      );
                    },
                    onPressed: () {
                      editOrAdd(index);
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
