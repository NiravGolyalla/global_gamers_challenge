import 'package:flutter/material.dart';
import 'package:global_gamers_challenge/Panels/EquipmentTab.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';
import '../my_app_state.dart';

class MissionTab extends StatefulWidget {
  @override
  State<MissionTab> createState() => _MissionTabState();
}

class _MissionTabState extends State<MissionTab> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Expanded(
      child: ListView.builder(
          // shrinkWrap: true,
          itemCount: appState.activeMissions.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: FractionallySizedBox(
                widthFactor: 2/3,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/page.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: MissionInfo(info: appState.activeMissions.elementAt(index)),
                ),
              ),
            );
          }),
    );
  }
}

class MissionInfo extends StatelessWidget {
  const MissionInfo({
    super.key,
    required this.info,
  });

  final Mission info;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(height: 15, width: 15, child: TierBox(id: info.tier)),
                Text(info.name, style: TextStyle(fontSize: 12),),
              ],
            ),
            Row(
              children: [
                Text("Exp:${info.expReward.toString()} ", style: TextStyle(fontSize: 12)),
                Image.asset("assets/images/coin.png", width: 12, height: 12, fit: BoxFit.fill,),
                Text(":${info.coinReward.toString()}", style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
        Spacer(),
        GestureDetector(child: Image.asset("assets/images/check.png", width: 40, height: 40, fit: BoxFit.fill,), onTap: () {appState.currentMission = info; appState.transfer = true; GoRouter.of(context).go('/home');},),
        SizedBox(width: 10,),
        GestureDetector(child: Image.asset("assets/images/close.png", width: 40, height: 40, fit: BoxFit.fill,), onTap: () => {appState.removeMission(info)},),
      ],);
  }
}
