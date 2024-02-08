import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../my_app_state.dart';
import '../my_app_state.dart';

class CharacterStats extends StatelessWidget {
  const CharacterStats({super.key,});
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var percent = appState.experience / appState.experienceMax;

    return Container(
      width: double.infinity,
      height: 100,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    height: 75,
                    width: 75,
                    child: Image.asset('assets/images/sus.png')),
                Column(
                  children: [
                    Text("Level: ${appState.level}"),
                    Text("Coins: ${appState.coins}"),
                    SizedBox(
                        width: 70,
                        child: LinearProgressIndicator(value: percent)),
                  ],
                ),
                ElevatedButton(onPressed: () {GoRouter.of(context).go('/home');}, child: Text("Next"))
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
