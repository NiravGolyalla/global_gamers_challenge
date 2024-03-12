
import 'dart:developer' as dev; 
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:google_fonts/google_fonts.dart';
import "Panels/MissionTab.dart";
import "Panels/CharacterStats.dart";
import 'dart:collection';
import 'router.dart';
import 'dart:async';
import 'my_app_state.dart';
import 'my_home_page.dart';
import "dart:math";
import 'package:shared_preferences/shared_preferences.dart';
import 'DB/db.dart';
import 'package:window_manager/window_manager.dart';

late final database;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = await SharedPreferences.getInstance();
  await windowManager.ensureInitialized();
  initializeDB();

  WindowOptions windowOptions = const WindowOptions(
    minimumSize: Size(500, 800),
    size: Size(500, 800),  
  );
  windowManager.setAspectRatio(5/8);
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  // Put game into full screen mode on mobile devices.
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  // Lock the game to portrait mode on mobile devices.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:[
          ChangeNotifierProvider(create: (context) => MyAppState()),
        ],
        child: Builder(builder: (context) {
          return MaterialApp.router(
            title: 'Eco Guild',
            theme: ThemeData(
              useMaterial3: true,
              textTheme: GoogleFonts.pressStart2pTextTheme(Theme.of(context).textTheme),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
            ),
            routerDelegate: router.routerDelegate,
            routeInformationParser: router.routeInformationParser,
            routeInformationProvider: router.routeInformationProvider,
          );
        }),);

  }
}
