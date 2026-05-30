import 'package:flutter/material.dart';

class MyChoiceChip extends StatelessWidget {
  final String word;
  final bool isSelected;
  final void Function() onSelected;
   MyChoiceChip({super.key, required this.word, required this.isSelected ,required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      label: Text(word, style: TextStyle(color: Colors.black)),
      selected: isSelected,
      disabledColor: Colors.blue,
      selectedColor: Colors.amber,
      onSelected: (_) {
        onSelected();
      },
    );
  }
}
