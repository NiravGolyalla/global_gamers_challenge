import 'package:flutter/material.dart';
import 'package:global_gamers_challenge/src/drop_box.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'config.dart';
import 'dart:math';
import 'package:flutter/rendering.dart';

class GameOne extends StatefulWidget {
  @override
  _GameOneState createState() => _GameOneState();
}

class _GameOneState extends State<GameOne> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: double.infinity,
      // width: double.infinity,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
          Row( mainAxisAlignment: MainAxisAlignment.center,
            children: [
            DropBox(),
            DropBox()
          ],),
          Draggable<String>(
            data: "item",
            child: Icon(Icons.delete), // Add the missing argument specifying a trash icon
            feedback: Icon(Icons.delete),
            childWhenDragging: Icon(null),
          )
        ]
      ),
    );
  }
}
