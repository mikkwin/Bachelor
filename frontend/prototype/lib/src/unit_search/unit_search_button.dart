import 'package:flutter/material.dart';

class UnitSearchButton extends StatefulWidget {
  final String initialText;
  final Icon icon;
  final void Function() onPressed;

  const UnitSearchButton({
    super.key,
    this.initialText = '',
    this.icon = const Icon(Icons.abc),
    required this.onPressed,
  });

  @override
  createState() => _UnitSearchButton();
}

class _UnitSearchButton extends State<UnitSearchButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed, // Call the onPressed function when tapped
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(10), // Add padding for better touch area
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ensure the column takes up only necessary space
          children: [
            Text(widget.initialText),
            widget.icon,
          ],
        ),
      ),
    );
  }
}
