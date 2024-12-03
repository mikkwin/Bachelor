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
      onTap: widget.onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.initialText),
            widget.icon,
          ],
        ),
      ),
    );
  }
}
