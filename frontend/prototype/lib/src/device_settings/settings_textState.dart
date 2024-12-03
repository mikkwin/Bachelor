import 'package:flutter/material.dart';

class SettingsTextstate extends StatefulWidget{

final String initialText;
final String label;
final void Function(String) onTextChange;
final String suffixText;

  @override
createState() => _SettingsTextState(); 

const SettingsTextstate ({
  super.key,
  this.initialText = "",
  this.label = "",
  required this.onTextChange,
  this.suffixText = "",

});
  
  
}

class _SettingsTextState extends State<SettingsTextstate> {
  late TextEditingController _controller;

  @override
  void initState() {
   super.initState();
    // Initialize the TextEditingController with the initialText
    _controller = TextEditingController(text: widget.initialText);
    // Add a listener to update the text when it changes
    _controller.addListener(() {
      widget.onTextChange(_controller.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number, // Show numeric keyboard
      controller: _controller,
      
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: widget.label,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixText: widget.suffixText,
      ),
    );
  }
}

