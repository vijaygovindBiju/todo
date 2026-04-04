import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/widget/task_slidabelaction.dart';

class TodoCard extends StatelessWidget {
  final String todoText;
  final bool isDone;
  final void Function() onPressed;
  final void Function(bool?) onChanged;
  final void Function() onPress;
  const TodoCard({
    super.key,
    required this.onChanged,
    required this.isDone,
    required this.todoText,
    required this.onPressed,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            CustomSlidableAction(
              onPressed: (_) => onPress(),
              child: Myslidabelaction(
                backgroundColor: Colors.red,
                child: Icon(Icons.delete, size: 40),
                onPress: onPress,
              ),
            ),
          ],
        ),
        startActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            CustomSlidableAction(
              onPressed: (_) => onPressed,
              child: Myslidabelaction(
                backgroundColor: Colors.blue,
                child: Icon(Icons.edit, size: 40),
                onPress: onPressed,
              ),
            ),
          ],
        ),

        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isDone ? Colors.yellow.shade400 : Colors.yellow[500],
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Transform.scale(
                      scale: 1.3,
                      child: Checkbox(value: isDone, onChanged: onChanged),
                    ),
                    Text(
                      todoText,
                      style: TextStyle(
                        color: isDone ? Colors.grey : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        decoration: isDone ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
