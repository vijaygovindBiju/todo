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
  late DatabaseHive taskProvider;

  @override
  void initState() {
    taskProvider = context.read<DatabaseHive>();

    taskProvider.taskCalling();
    super.initState();
  }

  void editOrAdd(int? index) async {
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
            List Tasks=provider.getTasks();
             return Container(
              child: ListView.builder(
                itemCount: Tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  return TodoCard(
                    onPress: () => {provider.remove(index)},
                    todoText: Tasks[index].text,
                    isDone: Tasks[index].isDone,
                    onChanged: (_) {
                      provider.onChange(
                        index,
                        Tasks[index].text,
                        Tasks[index].isDone,
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
