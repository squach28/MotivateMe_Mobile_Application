import 'package:motivateme_mobile_app/model/goal.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// class that manages the user's goals
// allows insertion, update, and deletion of goals on local sqlite database
class GoalManager {
  // inserts a goal into the sqlite database
  // param: goal   -   the goal to insert into the database
  Future<void> insertGoal(Goal goal) async {
    final Future<Database> database =
        openDatabase(join(await getDatabasesPath(), 'motivate_me.db'));
    final Database db = await database;

    await db.insert('Goals', goal.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // retrieves a list of the user's goals from the database

  Future<void> retrieveGoals() async {
    final Future<Database> database =
        openDatabase(join(await getDatabasesPath(), 'motivate_me.db'));

    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('Goals');

    for (var item in maps) {
      print('id: ' + item['id'].toString());
      print('title: ' + item['title']);
      print('description: ' + item['description']);
      print('isComplete: ' + item['is_complete'].toString());
    }

    return List.generate(maps.length, (i) {
      return Goal(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        isComplete: maps[i]['is_complete'] == 1 ? true : false,
      );
    });
  }
}
