import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';
import 'main.dart';

class MyAppState extends ChangeNotifier {
  int experience = database.getInt('experience') ?? 0;
  int scale = 2;
  int level = database.getInt('level') ?? 0;
  int coins = database.getInt('coins') ?? 0;
  List<Armor> armors = [];
  
  
  late int experienceMax;

  final LinkedList<Mission> activeMissions = LinkedList<Mission>();
  late Timer _timer;
  var rng = Random();

  Future<void> generateArmors() async{
    List<String> armorNames = [
      'chest1',
      'chest2',
      'chest3',
      "boots1",
      "boots2",
      "boots3",
    ];
    
    for (int i = 0; i < armorNames.length; i++) {
      Armor armor = Armor(
        id: i,
        name: armorNames[i],
        lvl: await database.getInt('${armorNames[i]}lvl') ?? 0,
      );
      armors.add(armor);
    }
    print(armors);
  }

  MyAppState() {
    startTimer();
    generateArmors();
    experienceMax = 100 * pow(scale, level).toInt();
  }


  void startTimer(){
    _timer = Timer.periodic(Duration(seconds: 6), (timer) {
      if(activeMissions.length < 10){
        var mission = createMission();
        activeMissions.add(mission);
        notifyListeners();
      }
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

  Future<void> upgradeArmor(int index) async {
    if (armors[index].lvl < 5) {
      armors[index].lvl += 1;
      await database.setInt("${armors[index].name}lvl", armors[index].lvl);
    }
    notifyListeners();
  }

  Future<void> save() async {
    await database.setInt('experience', experience);
    await database.setInt('level', level);
  }

  void gainCoins(int value) {
    coins += value;
    notifyListeners();
  }

  Mission createMission() {
    int expReward = rng.nextInt(51) + 50;
    int coinReward = rng.nextInt(10) + 1;
    
    return Mission('Mission', expReward, coinReward);
  }

  void completeMission(Mission entry) {
    if (activeMissions.length < 10) {
      _timer.cancel();
      startTimer();
    }
    gainEXP(entry.expReward);
    gainCoins(entry.coinReward);
    activeMissions.remove(entry);
    save();
    notifyListeners();
  }
}

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

class Armor {
  final int id;
  final String name;
  int lvl;

  Armor({required this.id , required this.name, required this.lvl});

  @override
  String toString() {
    return 'Armor: $name, Lvl: $lvl';
  }
}

