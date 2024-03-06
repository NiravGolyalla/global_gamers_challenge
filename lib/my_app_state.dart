import 'dart:async';
import 'dart:collection';
import 'dart:math';
import 'package:flutter/material.dart';

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
    startTimer();
  }


  void startTimer(){
    _timer = Timer.periodic(Duration(seconds: 6), (timer) {
      print(activeMissions.length);
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



