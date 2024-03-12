import 'package:flutter/material.dart';
import 'package:global_gamers_challenge/src/drop_box.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'config.dart';
import 'dart:math';
import 'package:flutter/rendering.dart';

import 'drag_icon.dart';

class GameThree extends StatefulWidget {
  final void Function(int score) increaseScore;
  final int difficulty;
  GameThree({required this.increaseScore, required this.difficulty});

  @override
  _GameThreeState createState() => _GameThreeState();
}

class _GameThreeState extends State<GameThree> {
  List<List<bool>> matrix = List.generate(6, (index) => List.filled(5, false));
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Drag All the Clothes in the Box", style: TextStyle(decoration: TextDecoration.none),),
        Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate((widget.difficulty + 1), (ind1) {
                return Row(
                  mainAxisAlignment:  MainAxisAlignment.center,
                  children: List.generate(5, (ind2) {
                    return Cloth(matrix:matrix,one: ind1, two: ind2);
                  }
                ));
              }
            )
            ),
          ],
        ),
        DonateBox(matrix: matrix,increaseScore:widget.increaseScore)
      ],
    );
  }
}

class Cloth extends StatelessWidget {
  const Cloth({
    super.key,
    required this.one,
    required this.two,
    required this.matrix,
  });
  final int one;
  final int two;
  final List<List<bool>> matrix;

  @override
  Widget build(BuildContext context) {
    List<int>stuff = [one, two];
    if(matrix[one][two]){
      return SizedBox(height: 80, width: 80,child: Image.asset("assets/images/empty.png", fit: BoxFit.cover,));
    } else{
      return Draggable<List>(
        data: stuff,
        feedback: SizedBox(height: 80, width: 80,child: Image.asset("assets/images/shirt.png", fit: BoxFit.cover,)),
        childWhenDragging: SizedBox(height: 80, width: 80,child: Image.asset("assets/images/empty.png", fit: BoxFit.cover,)),
        child: SizedBox(height: 80, width: 80,child: Image.asset("assets/images/shirt.png", fit: BoxFit.cover,)),
      );
    }
    
  }
}

class DonateBox extends StatelessWidget {
  const DonateBox({
    super.key,
    required this.matrix,
    required this.increaseScore,
    
  });
  final List<List<bool>> matrix;
  final void Function(int score) increaseScore;
  @override
  Widget build(BuildContext context) {
    return DragTarget<List>(
          builder: (context, candidateData, rejectedData) => 
          Container(
            height: 100,
            width: 100,
            // color: Colors.blue,
            child: Image(image: AssetImage("assets/images/donate.png"), width: 20, height: 20, fit: BoxFit.fill,)
          ),
          onAcceptWithDetails: (data){
            if(matrix[data.data[0]][data.data[1]] == false){
              matrix[data.data[0]][data.data[1]] = true;
              increaseScore(1);
            }
          },
        );

  }
}