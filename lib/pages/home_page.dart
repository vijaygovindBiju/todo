import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/widget/my_choice_chip.dart';
import 'package:todo/widget/task_dialog.dart';
import 'package:todo/widget/todo_card.dart';

class Home extends StatefulWidget {
  Home({super.key});
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
    final db = context.watch<DatabaseHive>();
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
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.yellow),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MyChoiceChip(
                  isSelected: (db.currentFilter == TaskFilter.all),
                  word: "All",
                  onSelected: () {
                    db.changeFilter(TaskFilter.all);
                  },
                ),
                MyChoiceChip(
                  isSelected: (db.currentFilter == TaskFilter.pending),
                  word: "Pending",
                  onSelected: () {
                    db.changeFilter(TaskFilter.pending);
                  },
                ),
                MyChoiceChip(
                  isSelected: (db.currentFilter == TaskFilter.complete),
                  word: "Completed",
                  onSelected: () {
                    db.changeFilter(TaskFilter.complete);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: Consumer<DatabaseHive>(
                builder: (_, provider, _) {
                  final List tasks = db.filteredTasks;
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
                            provider.onChange(index, task.text, !task.isDone);
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
          ),
        ],
      ),
    );
  }
}
