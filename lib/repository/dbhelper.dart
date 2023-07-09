import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:trello_app/model/Task_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper.internal();
  factory DatabaseHelper() => instance;

  static  Database? _database;

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDatabase();
    return _database;
  }

  DatabaseHelper.internal();

  Future<Database> initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'my_database4.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
  CREATE TABLE my_table (
    task_id INTEGER PRIMARY KEY,
    task_index INTEGER,
    project_id TEXT,
    project_name TEXT,
    owner_id INTEGER,
    owner_name TEXT,
    owner_avatar TEXT,
    executor_id INTEGER,
    executor_name TEXT,
    executor_avatar TEXT,
    task_date TEXT,
    term_date TEXT,
    name TEXT,
    priority TEXT,
    status TEXT
  )
''');  }
  Future<int> insertWords(TaskModel taskModel) async {
    final db = await database;
    var res =await db!.insert('my_table', {
      'task_id': taskModel.taskId,
      'task_index': taskModel.index,
      'project_id': taskModel.projectId,
      'project_name': taskModel.projectName,
      'owner_id': taskModel.ownerId,
      'owner_name': taskModel.ownerName,
      'owner_avatar': taskModel.ownerAvatar,
      'executor_id': taskModel.executorId,
      'executor_name': taskModel.executorName,
      'executor_avatar': taskModel.executorAvatar,
      'task_date': taskModel.taskDate,
      'term_date': taskModel.termDate,
      'name': taskModel.name,
      'priority': taskModel.priority,
      'status': taskModel.status,
    },
    conflictAlgorithm: ConflictAlgorithm.replace
    );

    return res;
  }

  Future<List<TaskModel>> getSelectWords(String query) async {
    var db = await database;
    final List<Map<String, dynamic>> maps = await db!.query(
        "my_table",
        where: 'name like ?',
        whereArgs: ['${query}%']);


    print(maps);
    return List.generate(maps.length, (index) {
      print(maps[index]);
      print("ishladi");
      return TaskModel.fromJson(maps[index]);
    });
  }

  Future<int> setFavourite(TaskModel taskModel) async {
    var db = await database;

    return db!.update(
      "my_table",
      taskModel.toJson(),
      where: 'name ?',
      whereArgs: [taskModel.name],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<void> updateData(int task_id, String newValue) async {
    // Get a reference to the database
    final database = openDatabase(
      join(await getDatabasesPath(), 'my_database4.db'),
    );

    // Update the data in the database
    await database.then((db) {
      db.update(
        'my_table',
        {'name': newValue},
        where: 'task_id = ?',
        whereArgs: [task_id],
      );
    });
  }

}
