import 'package:flutter/material.dart';

class DropBox extends StatefulWidget {
  final String parameter;
  final void Function(int score) increaseScore;
  final void Function() randomizeTag;

  DropBox({required this.parameter, required this.increaseScore, required this.randomizeTag});

  @override
  State<DropBox> createState() => _DropBoxState();
}

class _DropBoxState extends State<DropBox> {
  
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: DragTarget<String>(
          builder: (context, candidateData, rejectedData) => 
          Container(
            height: 100,
            width: 100,
            color: Colors.blue,
            child: Center(child: Text(widget.parameter)),
          ),
          onWillAccept: (data) {
            return data == widget.parameter;
          },
          onAccept: (data){
            // print("accepted");
            widget.increaseScore(1);
            widget.randomizeTag();
            // print("accepted1");
          },
          // onLeave: (data) => {print("rejected")},
        ));
  }
}
