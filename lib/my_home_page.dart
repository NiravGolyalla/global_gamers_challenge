import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:global_gamers_challenge/Panels/EquipmentTab.dart';
import 'package:global_gamers_challenge/main.dart';
import 'package:global_gamers_challenge/panels/CharacterStats.dart';
import 'package:global_gamers_challenge/panels/MissionTab.dart';
import 'package:global_gamers_challenge/panels/ShopTab.dart';
import 'package:global_gamers_challenge/src/gameone.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    var page = <Widget>[ShopTab(), MissionTab(), EquipmentTab()];
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.shopping_bag),label: 'Shop',),
          NavigationDestination(icon: Icon(Icons.checklist),label: 'Missions',),
          NavigationDestination(icon: Icon(Icons.inventory), label: 'Equipment'),
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
      ),
      body: Row(children: [
        Expanded(
            child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child:
                    Column(
                      children: [CharacterStats(), page[selectedIndex]]))),
      ]),
    );
  }
}