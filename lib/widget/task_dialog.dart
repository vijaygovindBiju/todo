import 'package:flutter/material.dart';

class Dialogbo extends StatefulWidget {
  final int? index;
  final String task;
  const Dialogbo({super.key, required this.index, required this.task});

  @override
  State<Dialogbo> createState() => _DialogboState();
}

class _DialogboState extends State<Dialogbo> {
  late TextEditingController _editingController;
  @override
  void initState() {
    _editingController = TextEditingController(text: widget.task);
    super.initState();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 20),
          Text(
            (widget.index != null) ? "Edit the text " : "Enter the new text",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          TextField(controller: _editingController, maxLines: 5, minLines: 3),
          SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(),
                    right: BorderSide(),
                    top: BorderSide(),
                    left: BorderSide(),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context, _editingController.text);
                  },
                  child: Text("Save"),
                ),
              ),
              SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(),
                    right: BorderSide(),
                    top: BorderSide(),
                    left: BorderSide(),
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextButton(
                  onPressed: () {
                    _editingController.clear();
                    Navigator.pop(context);
                  },
                  child: Text("Cancel"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
