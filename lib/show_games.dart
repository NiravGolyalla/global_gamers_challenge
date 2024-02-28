import 'package:flutter/material.dart';
import 'src/gameone.dart';
import 'package:flame/game.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';

class ShowGames extends StatelessWidget {
  ShowGames({super.key});
  late Timer timer;
  late var game;
  @override
  Widget build(BuildContext context) {
    timer = Timer(const Duration(seconds: 5), () {
      GoRouter.of(context).go('/');
    });
    game = GameOne.new;


    return Container(
      color: Colors.white,
      // padding: EdgeInsets.all(20),
      child: 
      
      Stack(
        children: [
          GameWidget.controlled(
              gameFactory: game,
              ), 
              SizedBox(height:10, width:double.infinity, child: LinearProgressIndicator(value:.5)),
        ]
      ),
      
      
      // Column(
      //   children: [
      //     // SizedBox.e()
          
      //   ],
      // ),
    );
  }
}
