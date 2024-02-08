import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../my_app_state.dart';

class MissionTab extends StatefulWidget {
  @override
  State<MissionTab> createState() => _MissionTabState();
}

class _MissionTabState extends State<MissionTab> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Expanded(
      child: ListView.builder(
          itemCount: appState.activeMissions.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: Text(appState.activeMissions.elementAt(index).toString()),
                onPressed: () {
                  appState.completeMission(appState.activeMissions.elementAt(index));
                },
              ),
            );
          }),
    );
  }
}
