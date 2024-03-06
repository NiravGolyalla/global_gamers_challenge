import 'package:flutter/material.dart';
import 'src/gameone.dart';
import 'package:flame/game.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

class ShowGames extends StatefulWidget {
  ShowGames({super.key});

  @override
  State<ShowGames> createState() => _ShowGamesState();
}

class _ShowGamesState extends State<ShowGames> with TickerProviderStateMixin{
  late Timer timer;
  final int timeLimit = 10;
  int score = 0;

  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: timeLimit),
    )..addListener((){setState((){});});
    controller.repeat(reverse: false);
    super.initState();
  }
  
  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

  void increaseScore(int _score){
    setState(() {
      score += _score; 
    });
  }


  Widget build(BuildContext context) {
    timer = Timer(Duration(seconds: timeLimit), () {
      if(mounted){
        GoRouter.of(context).go('/');
      }
    });

    return Container(
      color: Colors.white,
      child: Column(
        children: [
        SizedBox(
            height: 10,
            width: double.infinity,
            child: LinearProgressIndicator(value: controller.value)),
        Spacer(),
        GameOne(increaseScore: increaseScore,),
        Spacer(),
        SizedBox(
            height: 10,
            width: double.infinity,
            child: LinearProgressIndicator(value: score/5)),
      ]),
    );
  }
}
