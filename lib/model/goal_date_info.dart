// class that contains information about a goal's specific dates
// specifies which days the goals should occur
// specifies the start time and end time of the goal
// specifies the start week and end week of the goal
import 'dart:convert';

class GoalDateInfo {
  final Map<String, bool> goalDays;
  final DateTime startTime;
  final DateTime endTime;
  final DateTime startWeek;
  final DateTime endWeek;

  GoalDateInfo({this.goalDays, this.startTime, this.endTime, this.startWeek, this.endWeek});


    Map<String, dynamic> toMap() {
    return {
      'goalDays': jsonEncode(goalDays),
      'startTime': this.startTime,
      'endTime': this.endTime,
      'startWeek': this.startWeek,
      'endWeek': this.endWeek,

    };
  }

}