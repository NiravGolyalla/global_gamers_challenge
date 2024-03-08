import 'package:flutter/material.dart';
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
            EquipmentRow(
              id: 0,
            ),
            EquipmentRow(
              id: 1,
            ),
            Header(text: "Inventory:"),
            Grid(),
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
    return Text(
      text,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class Grid extends StatelessWidget {
  const Grid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InventoryRow(),
        InventoryRow(),
        InventoryRow(),
      ],
    );
  }
}

class InventoryRow extends StatelessWidget {
  const InventoryRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
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
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      ArmorBox(id: 1),
      Container(
        height: 100,
        width: 50,
      ),
      Row(
          children: List.generate(3, (index) {
        return GestureDetector(
            child: ArmorBox(id: index + 3 * widget.id),
            onTap: () => {
                  setState(() {
                    selectedIndex = index;
                  })
                });
      }))
    ]);
  }
}

class ArmorBox extends StatefulWidget {
  int id;

  ArmorBox({
    super.key,
    required this.id,
  });

  @override
  State<ArmorBox> createState() => _ArmorBoxState();
}

class _ArmorBoxState extends State<ArmorBox> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Stack(alignment: Alignment.center, children: [
      SizedBox(
        height: 100,
        width: 100,
        child: FittedBox(
            fit: BoxFit.fill,
            child: Image.asset(
                'assets/images/armor/${"chest1"}${appState.armors[widget.id].lvl}.png')),
        // fit: BoxFit.fill, child: Image.asset('assets/images/armor/${appState.armors[id].name}${appState.armors[id].lvl}.png')),
      ),
      Text(appState.armors[widget.id].lvl.toString()),
    ]);
  }
}

class EquipedDisplay extends StatefulWidget {
  int id;
  EquipedDisplay({
    required this.id,
    super.key,
  });

  @override
  State<EquipedDisplay> createState() => _EquipedDisplayState();
}

class _EquipedDisplayState extends State<EquipedDisplay> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return SizedBox(
        height: 100,
        width: 100,
        child: FittedBox(
            fit: BoxFit.fill,
            child: Image.asset(widget.id < 3 ? 'assets/images/armor/${"chest1"}${appState.armors[widget.id].lvl}.png' : 'assets/images/box.png') 
        )
        // fit: BoxFit.fill, child: Image.asset('assets/images/armor/${appState.armors[id].name}${appState.armors[id].lvl}.png')),
      );
  }
}
