import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:global_gamers_challenge/main.dart';
import 'package:provider/provider.dart';
import 'src/gameone.dart';
import 'src/gametwo.dart';
import 'src/gamethree.dart';
import 'package:go_router/go_router.dart';
import 'dart:async';
import 'my_app_state.dart';
import 'dart:math';
import "DB/db.dart";


class ShowGames extends StatefulWidget {
  ShowGames({super.key});

  @override
  State<ShowGames> createState() => _ShowGamesState();
}

class _ShowGamesState extends State<ShowGames> with TickerProviderStateMixin{
  late Timer timer;
  int timeLimit = 10;
  int score = 0;
  bool transfer = true;
  List<int> multiplesOfFive = List.generate(6, (index) => (index + 1) * 5);

  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: timeLimit),
    )..addListener((){setState((){});});
    controller.repeat(reverse: false);
    super.initState();
  }
  
  @override
  void dispose() {
    timer.cancel();
    controller.dispose();
    super.dispose();
  }

  void increaseScore(int _score){
    setState(() {
      score += _score; 
    });
  }


  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    List<String> missionNames = [
      'Recycle Mission',
      'Reduce Mission',
      'Reuse Mission',
    ];
    if(appState.currentMission.name == 'Recycle Mission' && (database.getInt('equipedchest') ?? 6) == 2){
      timeLimit = 10 + appState.armors[2].lvl + 1;
      controller.duration = Duration(seconds: timeLimit);
      controller.repeat(reverse: false);
    }
    else if(appState.currentMission.name == 'Reduce Mission' && (database.getInt('equipedchest') ?? 6) == 1){
      timeLimit = 10 + appState.armors[1].lvl + 1;
      controller.duration = Duration(seconds: timeLimit);
      controller.repeat(reverse: false);
    }
    else if(appState.currentMission.name == 'Reuse Mission' && (database.getInt('equipedchest') ?? 6) == 0){
      timeLimit = 10 + appState.armors[0].lvl + 1;
      controller.duration = Duration(seconds: timeLimit);
      controller.repeat(reverse: false);
    }
    // print((database.getInt('equipedchest') ?? 6));
    if((database.getInt('equipedboots') ?? 6) == 5 && transfer){
      // print((multiplesOfFive[appState.currentMission.tier]~/5));
      increaseScore((multiplesOfFive[appState.currentMission.tier]~/5));
      transfer = false;
    }

    
    timer = Timer(Duration(seconds: timeLimit), () {
      if(mounted){
        int remainder = score % 5;
        double val = min(1, (score - remainder) / multiplesOfFive[appState.currentMission.tier]);
        appState.score = val;
        if(appState.transfer){
          appState.completeMission(appState.currentMission);
          appState.transfer = false;
        }
        GoRouter.of(context).go('/');
      }
    });
    
    List<Widget> gameWidgets = [
      GameOne(increaseScore: increaseScore,),
      GameTwo(increaseScore: increaseScore,),
      GameThree(increaseScore: increaseScore,difficulty: 5,),
    ];

    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 10,
            width: double.infinity,
            child: LinearProgressIndicator(value: controller.value)),
          // Spacer(),
          Expanded(child: gameWidgets[missionNames.indexOf(appState.currentMission.name)]),
          
          ScoreBar(score: score, limit: multiplesOfFive[appState.currentMission.tier]),
        ],
      ),
    );
  }
}


class ScoreBar extends StatelessWidget {
  const ScoreBar({
    super.key,
    required this.score,
    required this.limit,
  });
  final int score;
  final int limit;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SizedBox(
          height: 10,
          width: double.infinity,
          child: LinearProgressIndicator(value: score/limit)),
      Row(children: [Spacer(),RewardBox(limit: .2, score: score/limit),Spacer(),RewardBox(limit: .4, score: score/limit),Spacer(),RewardBox(limit: .6, score: score/limit),Spacer(),RewardBox(limit: .8, score: score/limit),Spacer(),RewardBox(limit: 1, score: score/limit)],)
      ]
    );
  }
}

class RewardBox extends StatelessWidget {
  final double limit;
  final double score;
  const RewardBox({
    super.key,
    required this.limit,
    required this.score,
  });
  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage(score < limit ? "assets/images/present.png":"assets/images/open.png"), width: 20, height: 20, fit: BoxFit.fill,);
  }
}

