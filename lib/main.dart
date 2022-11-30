import 'package:flutter/material.dart';
import 'package:habit_tracker/Pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
//
//initialize hive---------------------------------------------------------------
//
  await Hive.initFlutter();
//
// Habit Database OPEN-BOX------------------------------------------------------
//
  await Hive.openBox("Habit_Database");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.deepPurple),
    );
  }
}
