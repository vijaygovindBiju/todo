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
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.4,
        maxWidth: MediaQuery.of(context).size.width * 0.97,
        minHeight: MediaQuery.of(context).size.height * 0.4,
        minWidth: MediaQuery.of(context).size.width * 0.97,
      ),
      backgroundColor: Colors.yellow[300],
      content: Column(
        children: [
          SizedBox(height: 40),
          Text(
            (widget.index != null) ? "Edit the text " : "Enter the new text",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          TextField(controller: _editingController, maxLines: 10, minLines: 5),
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
