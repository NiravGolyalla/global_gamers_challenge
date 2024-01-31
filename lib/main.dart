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
  int level = 0;

}


class MyHomePage extends StatefulWidget{
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;
  @override
  Widget build(BuildContext context){
    var page = <Widget>[MissionTab(),Placeholder()];
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: header(context),
          bottomNavigationBar: NavigationBar(
                  destinations: [
                    NavigationDestination(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.favorite),
                      label: 'Favorites'
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value){
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
          body: Row(
            children: [
              Expanded(
                child:Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page[selectedIndex],
                )
               ),
            ]
            ),
        );
      }
    );
  }
}

class MissionTab extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Center(
      child: Column(
        children: [
          SizedBox(height: 20,),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(height: 75,width: 75,child: Image.asset('assets/images/sus.png')),
              Column(children: [Text("Other"),Text("Other"),],),
            
          ],)
        ],
        )
    );  
  }
}

AppBar header(context) {
  return AppBar(
    title: Center(
      child: Column(
        children: [
          SizedBox(height: 100,),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(height: 75,width: 75,child: Image.asset('assets/images/sus.png')),
              Column(children: [Text("Other"),Text("Other"),],),
            
          ],)
        ],
        )
    ),
    centerTitle: true,
    // backgroundColor: Theme.of(context).accentColor,
  );
}