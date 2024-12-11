import 'dart:collection';

import 'package:flutter/material.dart';

class DataLoadingButton extends StatefulWidget {
  final String buttonName;
  final List<String> data;
  final TextStyle textStyle;
  final Icon prefixIcon;
  final bool enablePreview;
  final void Function() onPress;

  const DataLoadingButton(
      {super.key,
      this.buttonName = '',
      this.data = const [],
      this.textStyle = const TextStyle(),
      this.prefixIcon = const Icon(Icons.abc),
      this.enablePreview = true,
      required this.onPress});

  @override
  createState() => _DataLoadingButton();
}

class _DataLoadingButton extends State<DataLoadingButton>
    with TickerProviderStateMixin {
  late Queue<String> dataQueue;
  late AnimationController aController;

  @override
  void initState() {
    dataQueue = Queue<String>();
    dataQueue.addAll(widget.data);

    aController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )
      ..addListener(() {
        setState(() {
          if (aController.value >= 0.99 && dataQueue.isNotEmpty) {
            dataQueue.add(dataQueue.removeFirst());
          }
        });
      })
      ..repeat(reverse: false);
    super.initState();
  }

  @override
  void dispose() {
    aController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enablePreview) {
      return GestureDetector(
      onTap: () {
        widget.onPress.call();
      },
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 10), child:
        Card(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(
                          widget.buttonName,
                          style: widget.textStyle,
                        ))
                        ,
                        const SizedBox(width: 20,),
                        const Icon(Icons.keyboard_arrow_right)
                      ],
                    ))
                  ],
                )))),
      ),
    );
    }

    return GestureDetector(
      onTap: () {
        widget.onPress.call();
      },
      child: AnimatedContainer(
        duration: const Duration(seconds: 1),
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 10), child:
        Card(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(
                          widget.buttonName,
                          style: widget.textStyle,
                        ))
                        ,
                        Text(dataQueue.isEmpty ? "" : dataQueue.first),
                        const SizedBox(width: 20,),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: aController.value,
                              semanticsLabel: 'Circular progress indicator',
                            ),
                            const Icon(Icons.keyboard_arrow_right)
                          ],
                        )
                      ],
                    ))
                  ],
                )))),
      ),
    );
  }
}
