import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
        title: 'Namer App',
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
  int scale = 1;
  int level = 0;
  int coins = 0;

  void gainEXP() {
    experience += growth;
    if(experience >= experienceMax){
      level += ((experience)/experienceMax).floor();
      experience %= experienceMax;
      experienceMax *= scale;
    }
    notifyListeners();
  }

  void gainCoins() {
    coins += 1;
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    var page = <Widget>[Missions(), Placeholder()];
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        bottomNavigationBar: NavigationBar(
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
                icon: Icon(Icons.favorite), label: 'Favorites'),
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
            child: Column(children: [CharacterStats(),page[selectedIndex]]) 
            
            
          )),
        ]),
      );
    });
  }
}

class MissionTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("");
  }
}

class CharacterStats extends StatelessWidget {
  const CharacterStats({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var percent = appState.experience/appState.experienceMax;

    return Container(
      width: double.infinity,
      height: 100,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                    height: 75,
                    width: 75,
                    child: Image.asset('assets/images/sus.png')),
                Column(
                  children: [
                    Text("Level: ${appState.level}"),
                    Text("Coins: ${appState.coins}"),
                    SizedBox(
                      width: 70,
                      child: LinearProgressIndicator(value: percent)
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Missions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Column(
      children: [
        ElevatedButton(
                style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {appState.gainEXP();},
                child: Text('Gain Experience'),
              ),
        SizedBox(height: 10),
        ElevatedButton(
                style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                onPressed: () {appState.gainCoins();},
                child: Text('Gain Coins'),
              ),
      ],
    );
    
    // return ListView(
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.all(20),
    //       child: Text(""),
    //       // child: ElevatedButton(
    //       //   style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
    //       //   onPressed: () {},
    //       //   child: const Text('Enabled'),
    //       // ),
    //       // child: ElevatedButton(
    //       //         onPressed: (){
    //       //           // appState.GainEXP();
    //       //         },
    //       //         child: Text('Gain Experience'),
    //       //       ),
    //     ),
    //   ],
    // );
  }
}
