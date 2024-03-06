import 'package:flutter/material.dart';
import 'package:global_gamers_challenge/src/drop_box.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'config.dart';
import 'dart:math';
import 'package:flutter/rendering.dart';

import 'drag_icon.dart';

class GameOne extends StatefulWidget {
  final void Function(int score) increaseScore;
  GameOne({required this.increaseScore});

  @override
  _GameOneState createState() => _GameOneState();
}

class _GameOneState extends State<GameOne> {
  final List<String> tags = ["trash", "recycle"];
  late String _tag;
  late int _icon;

  @override
  void initState() {
    randomizeTag();
    super.initState();
  }

  void randomizeTag() {
    setState(() {
      _tag = tags[Random().nextInt(2)];
      _icon = Random().nextInt(2);
    });
  }
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
            DropBox(parameter: "trash", increaseScore: widget.increaseScore,randomizeTag: randomizeTag,),
            DropBox(parameter: "recycle",increaseScore: widget.increaseScore, randomizeTag: randomizeTag,),
          ],),
          DragIcon(tag: _tag,icon: _icon,)
        ]
      ),
    );
  }
}
