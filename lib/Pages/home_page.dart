import 'package:flutter/material.dart';
import 'package:habit_tracker/components/my_fab.dart';
import '../components/HabitTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => Structure();
}

class Structure extends State<HomePage> {
  //
  //data structure for todays list
  //
  List todaysHabitList = [
    ["Morning Run", false],
    ["Read Book", false],
    ["Coding", false],
    ["Dog walk", false],
  ];
  //
  //Checkbox TAPPED----------------------------------------------------------
  //
  void checkBoxTAPPED(bool? value, int index) {
    setState(() {
      todaysHabitList[index][1] = value;
    });
  }

//
//create a new habit------------------------------------------------------------
//
  void createNewHabit() {}
//
//Structure---------------------------------------------------------------------
//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      floatingActionButton: MyFloatingActionButton(onPressed: createNewHabit),
      body: ListView.builder(
        itemCount: todaysHabitList.length,
        itemBuilder: ((context, index) {
          return HabitTile(
            habitName: todaysHabitList[index][0],
            habitCompleted: todaysHabitList[index][1],
            onChanged: (value) => checkBoxTAPPED(value, index),
          );
        }),
      ),
    );
  }
}
