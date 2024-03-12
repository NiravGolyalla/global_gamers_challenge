import 'dart:async';
import '../main.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> initializeDB() async {
  WidgetsFlutterBinding.ensureInitialized();
  await database.setInt('experience', database.getInt('experience') ?? 0);  
  await database.setInt('level', database.getInt('level') ?? 0);  
  await database.setInt('coins', database.getInt('coins') ?? 0);  
  
  await database.setInt('equipedchest', database.getInt('equipedchest') ?? 6);  
  await database.setInt('equipedboots', database.getInt('equipedboots') ?? 6);  
  
  await database.setInt('chest1lvl', database.getInt('chest1lvl') ?? 0);  
  await database.setInt('chest2lvl', database.getInt('chest2lvl') ?? 0);  
  await database.setInt('chest3lvl', database.getInt('chest3lvl') ?? 0);  
  
  await database.setInt('boots1lvl', database.getInt('boots1lvl') ?? 0);  
  await database.setInt('boots2lvl', database.getInt('boots2lvl') ?? 0);  
  await database.setInt('boots3lvl', database.getInt('boots3lvl') ?? 0);    
}

Future<void> wipeDB() async {
  await database.setInt('experience', 0);  
  await database.setInt('level', 0);  
  await database.setInt('coins', 0);  
  await database.setInt('equipedchest', 6);  
  await database.setInt('equipedboots', 6);  
  await database.setInt('chest1lvl', 0);  
  await database.setInt('chest2lvl', 0);  
  await database.setInt('chest3lvl', 0);  
  await database.setInt('boots1lvl', 0);  
  await database.setInt('boots2lvl', 0);  
  await database.setInt('boots3lvl', 0);    
}


