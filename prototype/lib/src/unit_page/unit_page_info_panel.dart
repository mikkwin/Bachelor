import 'package:flutter/material.dart';

class InfoPanel extends StatefulWidget {
  final String infoText;
  final String info;
  final void Function() onButtonPress;

  const InfoPanel({
    super.key,
    this.infoText = '',
    this.info = '',
    required this.onButtonPress,
  });

  @override
  createState() => _InfoPanel();
}

class _InfoPanel extends State<InfoPanel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 5), child: 
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: const Color.fromARGB(255, 154, 154, 154))),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${widget.info}:",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(child:
                        Text(widget.infoText,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        textAlign: TextAlign.right,
                        )),
                      ],
                    )))),
        const SizedBox(
          width: 20,
        ),
        GestureDetector(
          child: const Icon(Icons.edit),
          onTap: () => widget.onButtonPress.call(),
        )
      ],
    ));
  }
}
