import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';
import '../my_app_state.dart';

class ShopTab extends StatefulWidget {
  @override
  State<ShopTab> createState() => _ShopTabState();
}

class _ShopTabState extends State<ShopTab> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Expanded(
      child: ListView.builder(
          itemCount: appState.armors.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: FractionallySizedBox(
                widthFactor: 2/3,
                child: ElevatedButton(
                  child: Text("Upgrade ${appState.armors.elementAt(index).toString()}"),
                  onPressed: () {
                    appState.upgradeArmor(index);
                  },
                ),
              ),
            );
          }),
    );
  }
}
