import 'package:flutter/material.dart';
import 'package:global_gamers_challenge/src/drop_box.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'config.dart';
import 'dart:math';
import 'package:flutter/rendering.dart';

import 'drag_icon.dart';

class GameTwo extends StatefulWidget {
  final void Function(int score) increaseScore;
  // final void Function(int score) increaseScore;
  GameTwo({required this.increaseScore});

  @override
  _GameTwoState createState() => _GameTwoState();
}

class _GameTwoState extends State<GameTwo> {
  List<bool> randomBools =
      List.generate(25, (index) => Random().nextInt(10) > 5);

  @override
  Widget build(BuildContext context) {
    int total = randomBools.where((element) => true).length;
    return Column(
      children: [
        Text(
          "Turn Off All Lights!",
          style: TextStyle(decoration: TextDecoration.none),
        ),
        Column(
          children: List.generate(5, (index1) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Switch(
                  on: randomBools[index],
                  increaseScore: widget.increaseScore,
                );
              }),
            );
          }
          ),
        )
      ],
    );
  }
}

class Switch extends StatefulWidget {
  final bool on;
  final void Function(int score) increaseScore;
  Switch({required this.on, required this.increaseScore});

  @override
  State<Switch> createState() => _SwitchState();
}

class _SwitchState extends State<Switch> {
  bool currState = true;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 80,
      child: GestureDetector(
          onTap: () {
            if (currState == true) {
              widget.increaseScore(1);
              currState = false;
            }
          },
          child: Image(
              image: AssetImage(widget.on && currState
                  ? "assets/images/on.png"
                  : "assets/images/off.png"))),
    );
  }
}
