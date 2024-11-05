import 'package:flutter/material.dart';

class PostMortemTextfield extends StatefulWidget {
  final String initialText;
  final String label;
  final void Function(String) onTextChanged;

  const PostMortemTextfield({
    super.key,
    this.initialText = '',
    this.label = '',
    required this.onTextChanged,
  });
  
  @override
  createState() => _PostMortemTextfieldState();

}

class _PostMortemTextfieldState extends State<PostMortemTextfield> {
  late String _text;

  @override
  void initState() {
    super.initState();
    _text = widget.initialText;
  }

  void _openTextDialog() async {
    final newText = await showDialog(
      context: context, 
      builder: (BuildContext context) {
        String dialogText = _text;
        return AlertDialog(
          title: Text(widget.label),
          content: TextField(
            controller: TextEditingController(text: dialogText),
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your text here...'
            ),
            onChanged: (value) {
              dialogText = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context, dialogText);
              }, 
              child: const Text("OK")
              )
          ],
        );
      },
      );

      if (newText != null) {
        setState(() {
          _text = newText;
        });
        widget.onTextChanged(newText);
      }
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openTextDialog,
      child: AbsorbPointer(
        child: TextField(
          controller: TextEditingController(text: _text),
          decoration: InputDecoration(
            labelText: widget.label,
            border: const OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}