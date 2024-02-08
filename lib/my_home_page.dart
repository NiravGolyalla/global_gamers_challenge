import 'package:flutter/material.dart';
import 'package:global_gamers_challenge/main.dart';
import 'package:global_gamers_challenge/panels/CharacterStats.dart';
import 'package:global_gamers_challenge/panels/MissionTab.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var page = <Widget>[Placeholder(), MissionTab(), Placeholder()];
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
                    Column(children: [CharacterStats(), page[selectedIndex]]))),
      ]),
    );
  }
}