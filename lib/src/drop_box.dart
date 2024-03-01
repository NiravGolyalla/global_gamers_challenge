import 'package:flutter/material.dart';

class DropBox extends StatefulWidget {
  @override
  State<DropBox> createState() => _DropBoxState();
}

class _DropBoxState extends State<DropBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: DragTarget<String>(
          builder: (context, candidateData, rejectedData) => Container(
            height: 100,
            width: 100,
            color: Colors.blue,
          ),
          onWillAccept: (data) {
            return true;
          },
          onAccept: (data){
            print("Accepted");
          },
          onLeave: (data) => {print("rejected")},
        ));
  }
}
