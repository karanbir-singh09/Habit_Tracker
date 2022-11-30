// REFER THE BOX
import 'package:habit_tracker/date/time/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("Habit_Database");

class HabitDatabase {
  List todaysHabitList = [];
  Map<DateTime, int> heatMapDataSet = {};

//create Initial default data
  void createDefaultData() {
    todaysHabitList = [
      ["Run", false],
      ["BreakFast", false],
      ["Code", false],
    ];
    _myBox.put("START_DATE", todaysDateFormatted());
  }

//load data if it already exists
  void loadData() {
//check if its a new day (yes or no)
//if yes
    if (_myBox.get(todaysDateFormatted()) == null) {
      todaysHabitList = _myBox.get("CURRENT_HABIT_LIST");
      for (int i = 0; i < todaysHabitList.length; i++) {
        todaysHabitList[i][1] = false;
      }
    }
//if NO
    else {
      todaysHabitList = _myBox.get(todaysDateFormatted());
    }
  }

//Update database
  void updateDatabase() {
//update todays entry
    _myBox.put(todaysDateFormatted(), todaysHabitList);

// Update Universal Database
    _myBox.put("CURRENT_HABIT_LIST", todaysHabitList);

//Calculate the Progress
    calculateHabitProgress();

//Load the HEAT MAP
    loadHeatMap();
  }

  void calculateHabitProgress() {
    int countCompleted = 0;
    for (int i = 0; i < todaysHabitList.length; i++) {
      if (todaysHabitList[i][1] = true) {
        countCompleted++;
      }
    }
    String percent = todaysHabitList.isEmpty
        ? '0.0'
        : (countCompleted / todaysHabitList.length).toStringAsFixed(1);

// key: "PERCENTAGE_SUMMARY_yyyymmdd"
// value: string of 1dp number between 0.0-1.0 inclusive

    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()}", percent);
  }

  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));

// count the number of days to load
    int daysInBetween = DateTime.now().difference(startDate).inDays;

// go from start date to today and add each percentage to the dataset
// "PERCENTAGE_SUMMARY_yyyymmdd" will be the key in the database
    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd = convertDateTimeToString(
        startDate.add(Duration(days: i)),
      );

      double strengthAsPercent = double.parse(
        _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
      );

// split the date/time up like below so it doesn't worry about hours/mins/secs etc.

      // year
      int year = startDate.add(Duration(days: i)).year;

// month
      int month = startDate.add(Duration(days: i)).month;

// day
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
      print(heatMapDataSet);
    }
  }
}
