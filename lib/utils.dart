import 'dart:collection';

import 'package:motivateme_mobile_app/service/goal_manager.dart';
import 'package:table_calendar/table_calendar.dart';

import 'model/subgoal.dart';

// loop through all goals in goals table
// get all subgoals from the subgoals table
// return a map of them
class CalendarUtils {
  final goalManager = GoalManager();

  var kEvents = LinkedHashMap<DateTime, List<SubGoal>>(
    equals: isSameDay,
    hashCode: getHashCode,
  ); 

  Future<Map<DateTime,List<SubGoal>>> fetchSubGoals() async {
    List<SubGoal> subGoals = await goalManager.retrieveSubGoals();
    
    Map<DateTime, List<SubGoal>> _kEventSource = {};

    for (SubGoal subGoal in subGoals) {
      if(!_kEventSource.keys.contains(subGoal.date)) {
        _kEventSource[subGoal.date] = [subGoal];
      } else {
        _kEventSource[subGoal.date].add(subGoal);
      }
    } 


    kEvents.addAll(_kEventSource);
    return _kEventSource;
  }
  // TODO change _kEventSOurce in a function and then have calendar.dart use a future builder based on that function

  final kFirstDay = DateTime(
      DateTime.now().year - 2, DateTime.now().month, DateTime.now().day);
  final kLastDay = DateTime(
      DateTime.now().year + 2, DateTime.now().month, DateTime.now().day);
  static int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  /// Returns a list of [DateTime] objects from [first] to [last], inclusive.
  List<DateTime> daysInRange(DateTime first, DateTime last) {
    final dayCount = last.difference(first).inDays + 1;
    return List.generate(
      dayCount,
      (index) => DateTime.utc(first.year, first.month, first.day + index),
    );
  }
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
