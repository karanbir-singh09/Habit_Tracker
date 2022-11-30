import 'package:flutter/material.dart';
import 'package:habit_tracker/components/my_fab.dart';
import '../components/HabitTile.dart';
import '../components/my_alert_box.dart';

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
  //Checkbox TAPPED-------------------------------------------------------------
  //
  void checkBoxTAPPED(bool? value, int index) {
    setState(() {
      todaysHabitList[index][1] = value;
    });
  }

//
//create a new habit------------------------------------------------------------
//
  final _newHabitNameController = TextEditingController();
  void createNewHabit() {
//
//Alter Dialog for new habit
//
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          hintText: 'Enter Habit Name',
          controller: _newHabitNameController,
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );
  }

//
//save New habit----------------------------------------------------------------
//
  void saveNewHabit() {
    setState(() {
      todaysHabitList.add([_newHabitNameController.text, false]);
    });
//clear the text
    _newHabitNameController.clear();
    Navigator.of(context).pop();
  }

//
//Cancel New Habit--------------------------------------------------------------
//
  void cancelDialogBox() {
    _newHabitNameController.clear();
    Navigator.of(context).pop();
  }

//
//open habit settings to edit---------------------------------------------------
//
  void openHabitSettings(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
            hintText: todaysHabitList[index](0),
            controller: _newHabitNameController,
            onSave: () => saveExistingHabit(index),
            onCancel: cancelDialogBox);
      },
    );
  }

//
//save existing habit with a new name-------------------------------------------
//
  void saveExistingHabit(int index) {
    setState(() {
      todaysHabitList[index][0] = _newHabitNameController.text;
    });
    _newHabitNameController.clear();
    Navigator.pop(context);
  }

//
// delete habit-----------------------------------------------------------------
//
  void deleteHabit(int index) {
    setState(() {
      todaysHabitList.removeAt(index);
    });
  }

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
            settingTapped: (context) => openHabitSettings(index),
            deleteTapped: (context) => deleteHabit(index),
          );
        }),
      ),
    );
  }
}
