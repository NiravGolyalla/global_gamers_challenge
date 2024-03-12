import 'package:flutter/material.dart';
import 'dart:math';

class DragIcon extends StatefulWidget {
  final String tag;
  final int icon;
  DragIcon({required this.tag, required this.icon});

  @override
  State<DragIcon> createState() => _DragIconState();
}

class _DragIconState extends State<DragIcon> {
  final List<String> itemsTrash = ["trashbag", "glass"];
  final List<String> itemsRecycle = ["cardboard", "plastic"];
  late Widget data;
  double width = 40;
  double height = 40;
  var rng = Random();

  @override
  Widget build(BuildContext context) {
    if (widget.tag == "trash") {
        data = SizedBox(height: height, width: width,child: Image.asset("assets/images/${itemsTrash[widget.icon]}.png", fit: BoxFit.cover,));
      } else {
        data = SizedBox(height: height, width: width,child: Image.asset("assets/images/${itemsRecycle[widget.icon]}.png", fit: BoxFit.cover,));
    }
    return Draggable<String>(
        data: widget.tag,
        child: data,
        feedback: data,
        childWhenDragging: SizedBox(height: height, width: width,child: Image.asset("assets/images/empty.png", fit: BoxFit.cover,)),
      );

  }
}
