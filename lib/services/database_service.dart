import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:task_alowcation_app/models/skill.dart';
import 'package:task_alowcation_app/models/staff.dart';
import 'package:task_alowcation_app/models/task.dart';

class DatabaseServices {
  static final DatabaseServices instance = DatabaseServices._init();
  static Database? _database;
  DatabaseServices._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('outotask.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE skills (
      skid INTEGER PRIMARY KEY AUTOINCREMENT,
      skname TEXT NOT NULL
      )

    ''');
    await db.execute('''
      CREATE TABLE staffs (
    stid INTEGER PRIMARY KEY AUTOINCREMENT,
    stname TEXT NOT NULL,
    gender TEXT NOT NULL,
    dob TEXT NOT NULL,
    skid INTEGER NOT NULL,
    phone TEXT NOT NULL,
    address TEXT NOT NULL,
    FOREIGN KEY (skid) REFERENCES skills(skid)
  )

    ''');
    await db.execute('''
      CREATE TABLE tasks (
      taid INTEGER PRIMARY KEY AUTOINCREMENT,
      taname TEXT NOT NULL,
      deadline datetime NOT NULL,
      stid INTEGER NOT NULL,
      availability INTEGER DEFAULT 0,
      FOREIGN KEY (stid) REFERENCES staffs(stid)
)

    ''');
  }

  Future<Skill> createSkill(Skill skill) async {
    final db = await instance.database;
    final skid = await db.insert(skillTable, skill.toJson());
    return skill.copy(skid: skid);
  }

  Future<Skill> readSkill({required int skid}) async {
    final db = await instance.database;
    final maps = await db.query(
      skillTable,
      columns: SkillFields.value,
      where: '${SkillFields.skid} = ?',
      whereArgs: [skid],
    );
    if (maps.isNotEmpty) {
      return Skill.fromJson(maps.first);
    } else {
      throw Exception('ID $skid not found');
    }
  }

  Future<List<Skill>> readAllSkills() async {
    final db = await instance.database;
    const orderBy = '${SkillFields.skid} ASC';
    final result = await db.query(skillTable, orderBy: orderBy);

    return result.map((json) => Skill.fromJson(json)).toList();
  }

  Future<int> updateSkill({required Skill student}) async {
    final db = await instance.database;
    return db.update(
      skillTable,
      student.toJson(),
      where: '${SkillFields.skid} = ?',
      whereArgs: [student.skid],
    );
  }

  Future<int> deleteSkill({required int skid}) async {
    final db = await instance.database;
    return db.delete(
      skillTable,
      where: '${SkillFields.skid} = ?',
      whereArgs: [skid],
    );
  }

  //=============Staff=================

  Future<Staff> createStaff(Staff staff) async {
    final db = await instance.database;
    final stid = await db.insert(staffTable, staff.toJson());
    return staff.copy(stid: stid);
  }

  Future<Staff> readStaff({required int stid}) async {
    final db = await instance.database;
    final maps = await db.query(
      staffTable,
      columns: StaffFields.value,
      where: '${StaffFields.stid} = ?',
      whereArgs: [stid],
    );

    if (maps.isNotEmpty) {
      return Staff.fromJson(maps.first);
    } else {
      throw Exception('ID $stid not found');
    }
  }

  Future<List<Staff>> readAllStaffs() async {
    final db = await instance.database;
    const orderBy = '${StaffFields.skid} ASC';
    final result = await db.query(staffTable, orderBy: orderBy);

    return result.map((json) => Staff.fromJson(json)).toList();
  }

  Future<int> deleteStaff({required int stid}) async {
    final db = await instance.database;
    return db.delete(
      staffTable,
      where: '${StaffFields.stid} = ?',
      whereArgs: [stid],
    );
  }

  Future<int> updateStarff({required Staff staff}) async {
    final db = await instance.database;

    return db.update(
      staffTable,
      staff.toJson(),
      where: '${StaffFields.stid} = ?',
      whereArgs: [staff.stid],
    );
  }

  //================Task================

  Future<List<int>> findStaff(DateTime deadline, int skid) async {
    final db = await instance.database;
    print("Skill Id: " + skid.toString());
    String query =
        "SELECT staffs.stid  FROM staffs LEFT JOIN tasks ON staffs.stid=tasks.stid where staffs.skid=? AND (tasks.deadline IS NULL  OR tasks.deadline< ? OR tasks.availability>99)";
    final List<Map<String, dynamic>> maps =
        await db.rawQuery(query, [skid, deadline.microsecondsSinceEpoch]);
    print(maps);
    List<int> stids = [];
    for (var map in maps) {
      stids.add(map['stid']);
    }
    print(stids);
    return stids.toList();
  }

  Future<Task> createTask(Task task) async {
    final db = await instance.database;
    final taid = await db.insert(taskTable, {
      "taname": task.taname,
      "deadline": task.deadline.microsecondsSinceEpoch,
      "stid": task.stid,
      "availability": task.availability,
    });
    print(task.stid);
    const orderBy = '${TaskFields.taid} DESC';
    final List<Map<String, dynamic>> result =
        await db.query(taskTable, orderBy: orderBy);
    List<Task> tasks = [];
    for (int i = 0; i < result.length; i++) {
      tasks.add(Task(
          taid: result[i]['taid'],
          taname: result[i]['taname'],
          deadline: DateTime.fromMicrosecondsSinceEpoch(result[i]['deadline']),
          stid: result[i]['stid'],
          availability: result[i]['availability']));
    }
    return task.copy(taid: tasks[0].taid);
  }

  Future<List<Task>> readAllTasks() async {
    final db = await instance.database;
    const orderBy = '${TaskFields.taid} ASC';
    final List<Map<String, dynamic>> result =
        await db.query(taskTable, orderBy: orderBy);
    List<Task> tasks = [];
    for (int i = 0; i < result.length; i++) {
      tasks.add(Task(
          taid: result[i]['taid'],
          taname: result[i]['taname'],
          deadline: DateTime.fromMicrosecondsSinceEpoch(result[i]['deadline']),
          stid: result[i]['stid'],
          availability: result[i]['availability']));
    }
    return tasks;
  }

  Future<int> deleteTask({required int taid}) async {
    final db = await instance.database;
    return db.delete(
      taskTable,
      where: '${TaskFields.taid} = ?',
      whereArgs: [taid],
    );
  }

  Future<int> updateTask({required Task task}) async {
    final db = await instance.database;
    print("avil: " + task.availability.toString());
    print("Task id: " + task.taid.toString());
    return await db.update(
      taskTable,
      {
        "taname": task.taname,
        "deadline": task.deadline.microsecondsSinceEpoch,
        "stid": task.stid,
        "availability": task.availability,
      },
      where: '${TaskFields.taid} = ?',
      whereArgs: [task.taid],
    );
  }

  Future clone() async {
    final db = await instance.database;
    db.close();
  }
}
