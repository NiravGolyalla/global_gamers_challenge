import 'dart:async';
import 'dart:collection';
import 'dart:ffi';
import 'dart:math';
import 'package:flutter/material.dart';
import 'main.dart';
import 'DB/db.dart';

class MyAppState extends ChangeNotifier {
  int experience = database.getInt('experience') ?? 0;
  int scale = 2;
  int level = database.getInt('level') ?? 0;
  int coins = database.getInt('coins') ?? 0;
  List<Armor> armors = [];
  List<int> inventory = [];
  int called = 0;
  double score = 0;
  bool transfer = false;
  int currentMissionIndex = 0;

  late Mission currentMission;
  late int experienceMax;

  final LinkedList<Mission> activeMissions = LinkedList<Mission>();
  late Timer _timer;
  var rng = Random();

  Future<void> generateArmorsInventory() async {
    List<String> armorNames = [
      'chest1',
      'chest2',
      'chest3',
      "boots1",
      "boots2",
      "boots3",
    ];
    List<String> armorEffect = [
      'More time in Reuse missions',
      'More time in Reduce missions',
      'More time in Recycle missions',
      "More EXP Reward",
      "More Coin Reward",
      "Guarentee Minimum Reward",
    ];

    for (int i = 0; i < armorNames.length; i++) {
      Armor armor = Armor(
        id: i,
        name: armorNames[i],
        lvl: await database.getInt('${armorNames[i]}lvl') ?? 0,
        effect: armorEffect[i],
      );
      armors.add(armor);
    }
  }

  MyAppState() {
    startTimer();
    generateArmorsInventory();
    experienceMax = 100 * pow(scale, level).toInt();
  }

  void resetBD() {
    wipeDB();
    notifyListeners();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 6), (timer) {
      if (activeMissions.length < 10) {
        var mission = createMission();
        activeMissions.add(mission);
        notifyListeners();
      }
    });
  }

  void gainEXP(int value) {
    experience += value;
    while(experience >= experienceMax) {
      level += ((experience) / experienceMax).floor();
      experience %= experienceMax;
      experienceMax *= scale;
    }
    notifyListeners();
  }

  Future<void> upgradeArmor(int index) async {
    int cost = 10 * pow(2, armors[index].lvl+1).toInt();
    if (armors[index].lvl < 5  && coins >= cost) {
      armors[index].lvl += 1;
      coins -= cost;
      await database.setInt("${armors[index].name}lvl", armors[index].lvl);
    }
    notifyListeners();
  }

  Future<void> save() async {
    await database.setInt('experience', experience);
    await database.setInt('level', level);
    await database.setInt('coins', coins);
  }
  
  Future<void> updateEquiped(int id,int value) async {
    await database.setInt(['equipedchest','equipedboots'][id], value);
  }

  void gainCoins(int value) {
    coins += value;
    notifyListeners();
  }

  Mission createMission() {
    List<String> missionNames = [
      'Reuse Mission',
      'Reduce Mission',
      'Recycle Mission',
    ];
    String name = missionNames[rng.nextInt(missionNames.length)];
    int expReward = rng.nextInt(51) + 50;
    int coinReward = rng.nextInt(10) + 1;
    int tier = level + rng.nextInt(3) - 1;
    if (tier >= 6) {
      tier = 5;
    }
    if (tier < 0) {
    tier = 0;
  }
    return Mission(name, expReward, coinReward,tier);
  }

  void completeMission(Mission entry) {
    if (activeMissions.length < 10) {
      _timer.cancel();
      startTimer();
    }
    gainEXP((entry.expReward * score).toInt());
    gainCoins((entry.coinReward * score).toInt());

    if((database.getInt('equipedboot') ?? 6) == 3){
      gainEXP((armors[3].lvl+1));
    }

    if((database.getInt('equipedboot') ?? 6) == 4){
      gainEXP((armors[4].lvl+1));
    }
    
    activeMissions.remove(currentMission);
    transfer = false;
    save();
    notifyListeners();
  }
  void removeMission(Mission entry) {
    if (activeMissions.length < 10) {
      _timer.cancel();
      startTimer();
    }
    activeMissions.remove(entry);
    notifyListeners();
  }
}


final class Mission extends LinkedListEntry<Mission> {
  final String name;
  final int tier;
  final int expReward;
  final int coinReward;
  
  Mission(this.name, this.expReward, this.coinReward, this.tier);
}

class Armor {
  final int id;
  final String name;
  int lvl;
  final String effect;

  Armor({required this.id, required this.name, required this.lvl, required this.effect});

  @override
  String toString() {
    return 'Armor: $name, Lvl: $lvl';
  }
}
