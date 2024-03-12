import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../my_app_state.dart';
import '../my_app_state.dart';
import 'EquipmentTab.dart';

class CharacterStats extends StatelessWidget {
  const CharacterStats({super.key,});
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var percent = appState.experience / appState.experienceMax;

    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/top.png"), fit: BoxFit.fill),
      ),
      width: double.infinity,
      height: 120,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    Text("Guild Ranking:"),
                    SizedBox(height: 75,width: 75,child: TierBox(id: appState.level,)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("Exp: "),
                        SizedBox(width: 70, child: LinearProgressIndicator(value: percent)),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset("assets/images/coin.png", width: 24, height: 24, fit: BoxFit.fill,),
                        Text(": ${appState.coins}"),
                      ],
                    ),
                    
                  ],
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
