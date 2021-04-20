import 'package:motivateme_mobile_app/model/goal.dart';
import 'package:motivateme_mobile_app/model/subgoal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

// class that manages the user's goals
// allows insertion, update, and deletion of goals on local sqlite database
class GoalManager {
  Future<void> createGoalTable(Goal goal) async {
    final Future<Database> database =
        openDatabase(join(await getDatabasesPath(), 'motivate_me.db'));
    final Database db = await database;
    String formattedTitle = goal.title.replaceAll(' ', '_');
    String goalTableCreation = 'CREATE TABLE IF NOT EXISTS ' +
        formattedTitle +
        '(gid INTEGER PRIMARY KEY, id INTEGER, ' +
        'date' +
        ' DATETIME, ' +
        'completed' +
        ' INTEGER, ' +
        'comment' +
        ' TEXT, ' +
        'path_to_picture' +
        ' TEXT)';
    await db.execute(goalTableCreation);
  }

  // inserts a goal into the sqlite database
  // param: goal   -   the goal to insert into the database
  Future<void> insertGoal(Goal goal) async {
    final Future<Database> database =
        openDatabase(join(await getDatabasesPath(), 'motivate_me.db'));
    final Database db = await database;
    for(var thing in goal.formatForDatabase().entries) {
      print(thing.key + ' ' + thing.value.toString());
    }
    await db.insert('Goals', goal.formatForDatabase(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    createGoalTable(goal);
    initializeGoalDates(goal);
  }

  Future<void> initializeGoalDates(Goal goal) async {
    final Future<Database> database =
        openDatabase(join(await getDatabasesPath(), 'motivate_me.db'));
    final Database db = await database;
    int counter = 1;
    DateTime currentDate = goal.startDate;
    while (currentDate != goal.endDate) {
      String day = DateFormat.EEEE().format(currentDate);
      
      if (goal.goalDays[day] == true) {
        await db.insert(goal.title, {
          'gid': counter,
          'id': goal.id,
          'date': currentDate.toIso8601String(),
          'completed': null,
          'comment': null,
          'path_to_picture': null,
        });
        counter++;
      } 
      currentDate = currentDate.add(Duration(days: 1));
      print(currentDate);
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

  Future<void> sampleQuery(Goal goal) async {
    final Future<Database> database =
        openDatabase(join(await getDatabasesPath(), 'motivate_me.db'));

    final Database db = await database;

    var result = await db.query(goal.title);
    print(result.length);
  }

  // function when goal is completed (success)
  Future<void> completeGoal(SubGoal subgoal) async {
        final Future<Database> database =
        openDatabase(join(await getDatabasesPath(), 'motivate_me.db'));

    final Database db = await database;
    String findGoalTitleQuery = 'SELECT title FROM Goals WHERE id = ' + subgoal.id.toString();
    List<Map<String, Object>> title = await db.query(findGoalTitleQuery);
    String formattedGoalTitle = title.first['title'].toString().replaceAll(' ', '_');
    String completeGoalQuery = 'UPDATE ' + formattedGoalTitle + ' SET completed = 1 WHERE gid = ' + subgoal.gid.toString();
    db.execute(completeGoalQuery);
  }
  // function when goal is uncompleted (fail)
  // function when goal is deleted
  
}
