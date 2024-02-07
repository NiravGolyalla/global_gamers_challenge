import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "Panels/MissionTab.dart";
import "Panels/CharacterStats.dart";
import 'dart:collection';
import 'dart:async';
import 'my_home_page.dart';
import "dart:math";


final class Mission extends LinkedListEntry<Mission> {
  final String name;
  final int expReward;
  final int coinReward;
  @override
  String toString() {
    return 'Mission: $name, Exp Reward: $expReward, Coin Reward: $coinReward';
  }

  Mission(this.name, this.expReward, this.coinReward); 
}

void main() {
  // Game game = Game();
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  runApp(MyApp());

  // runApp(GameWidget(game: game));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Enivronmental Guild',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  int experience = 0;
  int experienceMax = 100;
  int growth = 10;
  int scale = 2;
  int level = 0;
  int coins = 0;

  final LinkedList<Mission> activeMissions = LinkedList<Mission>();
  late Timer _timer;
  var rng = Random();

  MyAppState() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      var mission = createMission();
      activeMissions.add(mission);
      notifyListeners();
    });
  }

  void gainEXP(int value) {
    experience += value;
    if (experience >= experienceMax) {
      level += ((experience) / experienceMax).floor();
      experience %= experienceMax;
      experienceMax *= scale;
    }
    notifyListeners();
  }

  void gainCoins(int value) {
    coins += value;
    notifyListeners();
  }

  Mission createMission() {
    int expReward = rng.nextInt(51) + 50;
    int coinReward = rng.nextInt(11);
    
    return Mission('Mission', expReward, coinReward);
  }

  void completeMission(Mission entry) {
    gainEXP(entry.expReward);
    gainCoins(entry.coinReward);
    activeMissions.remove(entry);
    notifyListeners();
  }
}



