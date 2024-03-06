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
  final List<IconData> itemsTrash = [Icons.delete, Icons.close];
  final List<IconData> itemsRecycle = [Icons.add, Icons.open_in_browser];
  late Icon data;
  var rng = Random();

  @override
  Widget build(BuildContext context) {
    if (widget.tag == "trash") {
        data = Icon(itemsTrash[widget.icon]);
      } else {
        data = Icon(itemsRecycle[widget.icon]);
    }
    return Draggable<String>(
        data: widget.tag,
        child: data,
        feedback: data,
        childWhenDragging: Icon(null),
      );

  }
}
