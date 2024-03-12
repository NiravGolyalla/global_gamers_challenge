import 'package:flutter/material.dart';
import 'package:global_gamers_challenge/DB/db.dart';
import 'package:global_gamers_challenge/Panels/EquipmentTab.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';
import '../my_app_state.dart';
import 'dart:math';

class ShopTab extends StatefulWidget {
  @override
  State<ShopTab> createState() => _ShopTabState();
}

class _ShopTabState extends State<ShopTab> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Column(children: [
      Header(
        text: "Shop:",
      ),
      ListView.builder(
          shrinkWrap: true,
          itemCount: appState.armors.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: FractionallySizedBox(
                widthFactor: 2 / 3,
                child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/page.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: UpgradeBox(index: index, appState: appState)),
              ),
            );
          }),
    ]);
  }
}

class UpgradeBox extends StatelessWidget {
  final int index;
  const UpgradeBox({
    super.key,
    required this.appState,
    required this.index,
  });

  final MyAppState appState;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ArmorBox(id: index, width: 50, height: 50),
          Spacer(),
          Text(
            "Upgrade:",
            style: TextStyle(fontSize: 10),
          ),
          GestureDetector(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  "assets/images/button.png",
                  width: 80,
                  height: 40,
                  fit: BoxFit.fill,
                ),
                Row(
                  
                  children: [
                  Text("${10 * pow(2, appState.armors[index].lvl+1).toInt()}"),
                  Image.asset("assets/images/coin.png", width: 24, height: 24, fit: BoxFit.fill,),
                ]),
              ],
            ),
            onTap: () => {appState.upgradeArmor(index)},
          ),
        ],
      ),
    );
  }
}
