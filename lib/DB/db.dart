import 'dart:async';
import '../main.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> initializeDB() async {
  WidgetsFlutterBinding.ensureInitialized();
  await database.setInt('experience', database.getInt('experience') ?? 0);  
  await database.setInt('level', database.getInt('level') ?? 0);  
  await database.setInt('coins', database.getInt('coins') ?? 0);  
  
  await database.setInt('equipedchest', database.getInt('equipedchest') ?? 3);  
  await database.setInt('equipedboots', database.getInt('equipedboots') ?? 3);  
  
  await database.setInt('chest1lvl', database.getInt('chest1lvl') ?? 0);  
  await database.setInt('chest2lvl', database.getInt('chest2lvl') ?? 0);  
  await database.setInt('chest3lvl', database.getInt('chest3lvl') ?? 0);  
  
  await database.setInt('boots1lvl', database.getInt('boots1lvl') ?? 0);  
  await database.setInt('boots2lvl', database.getInt('boots2lvl') ?? 0);  
  await database.setInt('boots3lvl', database.getInt('boots3lvl') ?? 0);  
  
  await database.setInt('inventory1', database.getInt('inventory1') ?? 0);  
  await database.setInt('inventory2', database.getInt('inventory2') ?? 0);  
  await database.setInt('inventory3', database.getInt('inventory3') ?? 0);  
  await database.setInt('inventory4', database.getInt('inventory4') ?? 0);  
  await database.setInt('inventory5', database.getInt('inventory5') ?? 0);  
  await database.setInt('inventory6', database.getInt('inventory6') ?? 0);  
  await database.setInt('inventory7', database.getInt('inventory7') ?? 0);  
  await database.setInt('inventory8', database.getInt('inventory8') ?? 0);  
  await database.setInt('inventory9', database.getInt('inventory9') ?? 0);  
  
    


}


