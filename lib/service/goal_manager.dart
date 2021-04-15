import 'package:motivateme_mobile_app/model/goal.dart';
import 'package:motivateme_mobile_app/model/goal_date_info.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

// class that manages the user's goals
// allows insertion, update, and deletion of goals on local sqlite database
class GoalManager {
  // inserts a goal into the sqlite database
  // param: goal   -   the goal to insert into the database
  Future<void> insertGoal(Goal goal) async {
    final Future<Database> database =
        openDatabase(join(await getDatabasesPath(), 'motivate_me.db'));
    final Database db = await database;
    /*
    String goalTableCreation = 'CREATE TABLE IF NOT EXISTS ' +
        goal.title +
        '(gid INTEGER PRIMARY KEY, id INTEGER, ' +

        'start_time' +
        ' DATETIME, ' +
        'end_time' +
        ' DATETIME, ' +
        'start_week' +
        ' DATETIME, ' +
        'end_week' +
        ' DATETIME)';
    await db.execute(goalTableCreation); */
    await db.insert('Goals', goal.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> initializeGoalDates(Goal goal) async {
    DateTime now = DateTime.now();
    // monday = 1
    // sunday = 7
    // 3 % 1 = 0
    // algorithm to get the start week and end week of a goal
    for (var kvp in goal.goalDays.entries) {
      if (kvp.value) {
        if (kvp.key == DateFormat('E').format(DateTime.now())) {
          DateTime goalDate = DateTime.now();
          for (int i = 0; i < 52; i++) {
            goalDate = goalDate.add(Duration(days: 7));
            print(goalDate);
          }
        } else {}
      }
    }
    if (now.weekday != DateTime.monday) {
      print(now.weekday);
      int daysUntilMonday = DateTime.sunday + DateTime.monday - now.weekday;
      print(daysUntilMonday);
      DateTime startWeek = now.add(Duration(days: daysUntilMonday));
      DateTime endWeek =
          now.add(Duration(days: daysUntilMonday + DateTime.saturday));
      print(startWeek);
      print(endWeek);
    } else {
      DateTime startWeek = now;
      DateTime endWeek = now.add(Duration(days: DateTime.saturday));
      print(startWeek);
      print(endWeek);
    }
  }

  // retrieves a list of the user's goals from the database

  Future<List<Goal>> retrieveGoals() async {
    final Future<Database> database =
        openDatabase(join(await getDatabasesPath(), 'motivate_me.db'));

    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('Goals');

    return List.generate(maps.length, (i) {
      return Goal(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        goalDays: {
          'monday': maps[i]['monday'] == 1 ? true : false,
          'tuesday': maps[i]['tuesday'] == 1 ? true : false,
          'wednesday': maps[i]['wednesday'] == 1 ? true : false,
          'thursday': maps[i]['thursday'] == 1 ? true : false,
          'friday': maps[i]['friday'] == 1 ? true : false,
          'saturday': maps[i]['saturday'] == 1 ? true : false,
          'sunday': maps[i]['sunday'] == 1 ? true : false
        },
        startDate: DateTime.parse(maps[i]['start_date']),
        endDate: DateTime.parse(maps[i]['end_date']),
        startTime: DateTime.parse(maps[i]['start_time']),
        endTime: DateTime.parse(maps[i]['end_time']),
        isComplete: maps[i]['is_complete'] == 1 ? true : false,
      );
    });
  }

  Future<int> retrieveNumberOfGoals() async {
    final Future<Database> database =
        openDatabase(join(await getDatabasesPath(), 'motivate_me.db'));

    final Database db = await database;

    final String countQuery = 'SELECT COUNT(*) FROM Goals';

    var tableCount = await db.rawQuery(countQuery);

    print(tableCount.first['COUNT(*)'].runtimeType);

    return tableCount.first['COUNT(*)'];
  }

  Future<void> sampleQuery() async {
    final Future<Database> database =
        openDatabase(join(await getDatabasesPath(), 'motivate_me.db'));

    final Database db = await database;

    var result = await db.query('Goals');
    for (var row in result) {
      for (var entry in row.entries) {
        print(entry);
      }
    }
  }
}
