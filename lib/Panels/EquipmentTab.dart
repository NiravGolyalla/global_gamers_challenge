import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../main.dart';
import '../my_app_state.dart';

class EquipmentTab extends StatefulWidget {
  @override
  State<EquipmentTab> createState() => _EquipmentTabState();
}

class _EquipmentTabState extends State<EquipmentTab> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Container(
      child: Expanded(
        child: ListView(
          shrinkWrap: true,
          children: [
            Header(
              text: "Equipment:",
            ),
            Text("Chest:"),
            EquipmentRow(
              id: 0,
            ),
            Text("Boots:"),
            EquipmentRow(
              id: 1,
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String text;
  const Header({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/page.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class EquipmentRow extends StatefulWidget {
  final int id;
  const EquipmentRow({
    required this.id,
    super.key,
  });

  @override
  State<EquipmentRow> createState() => _EquipmentRowState();
}

class _EquipmentRowState extends State<EquipmentRow> {
  late int selectedIndex;
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    selectedIndex =
        database.getInt(['equipedchest', 'equipedboots'][widget.id]) ?? 6;
    return Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start, children: [
      EquipedDisplay(id: selectedIndex),
      SizedBox(
        height: 100,
        width: 50,
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(3, (index) {
        return Column(
          children: [
            GestureDetector(
                child: ArmorBox(id: index + 3 * widget.id, width: 100, height: 100),
                onTap: () => {
                      setState(() {
                        selectedIndex = index + 3 * widget.id;
                        appState.updateEquiped(widget.id, selectedIndex);
                        // print(selectedIndex);
                      })
                    }),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Set the background color to white
                ),
                width: 100,
                height : 70,
                child: Text(
                  appState.armors[index + 3 * widget.id].effect,
                  style: TextStyle(fontSize: 10),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        );
      }))
    ]);
  }
}

class ArmorBox extends StatelessWidget {
  final int id;
  final double width;
  final double height;

  ArmorBox({
    super.key,
    required this.id,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Column(
      children: [
        Stack(alignment: Alignment.topRight, children: [
          SizedBox(
            height: height,
            width: width,
            child: FittedBox(
                fit: BoxFit.fill,
                child: Image.asset('assets/images/armor/background.png')),
          ),
          SizedBox(
            height: height,
            width: width,
            child: FittedBox(
                fit: BoxFit.fill,
                child: Image.asset(
                    'assets/images/armor/${appState.armors[id].name}.png')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(height: height/5, width: width/5, child: TierBox(id: appState.armors[id].lvl)),
          ),
        ]),
      ],
    );
  }
}

class EquipedDisplay extends StatelessWidget {
  final int id;
  EquipedDisplay({
    required this.id,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Stack(alignment: Alignment.topRight, children: [
      SizedBox(
        height: 100,
        width: 100,
        child: FittedBox(
            fit: BoxFit.fill,
            child: Image.asset('assets/images/armor/background.png')),
      ),
      SizedBox(
          height: 100,
          width: 100,
          child: FittedBox(
              fit: BoxFit.fill,
              child: Image.asset(id < 6
                  ? 'assets/images/armor/${appState.armors[id].name}.png'
                  : 'assets/images/armor/background.png'))),
      Builder(
        builder: (context) {
          if (id < 6){
            return Padding(padding: const EdgeInsets.all(8.0),child: SizedBox(height: 20, width: 20, child: TierBox(id: appState.armors[id].lvl)));
          }
          return SizedBox(height: 20, width: 20);   
        },
      ),
      
        
      
    ]);
  }
}

class TierBox extends StatelessWidget {
  final int id;
  const TierBox({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    List<String> tiers = ['f', 'd', 'c', 'b', 'a', 's'];
    return FittedBox(
        fit: BoxFit.fill, child: Image.asset('assets/images/tier/${tiers[id]}.png'));
  }
}
