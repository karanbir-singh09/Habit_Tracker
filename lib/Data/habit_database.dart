// REFER THE BOX
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("Habit_Database");

class HabitDatabase {
  List todaysHabitList = [];

//create Initial default data
  void createDefaultData() {}

//load data if it already exists
  void loadData() {}

//Update database
  void updateDatabase() {}
}
