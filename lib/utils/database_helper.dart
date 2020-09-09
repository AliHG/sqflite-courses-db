import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

import '../model/course.dart';

class DatabaseHelper {
// build a Singleton

  // 1-- Factory constructor :: DatabaseHelper dbHelper = DatabaseHelper();
  // DatabaseHelper._(); // private  constructor to create instance of DatabaseHelper
  // static final DatabaseHelper _instance =
  //     DatabaseHelper._(); // Singleton DatabaseHelper
  // factory DatabaseHelper() => _instance; //Factory constructor

  // 2-- Static field with getter :: DatabaseHelper dbHelper = DatabaseHelper.instance;
  // DatabaseHelper._(); // private  constructor to create instance of DatabaseHelper
  // static final DatabaseHelper _instance = DatabaseHelper._(); // Singleton DatabaseHelper
  // static  DatabaseHelper get instance => _instance; // Static field with getter

  // 3-- Static field :: DatabaseHelper dbHelper = DatabaseHelper.instance;
  DatabaseHelper._(); // private  constructor to create instance of DatabaseHelper
  static final DatabaseHelper instance =
      DatabaseHelper._(); // Singleton DatabaseHelper

  static Database _database; // Singleton Database

  String coursesTable = 'courses';
  String colId = 'id';
  String colName = 'name';
  String colHours = 'hours';
  String colContent = 'content';
  String colLevel = 'level';

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    // define the path to the database
    String path = p.join(await getDatabasesPath(), 'school.db');

    //open the database
    _database = await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
    return _database;
  }

  void _createDB(Database db, int version) async {
    await db.execute(
        'create table $coursesTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,'
        '$colName TEXT , $colContent varchar(255), $colHours integer )');
  }

  void _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute(
          'ALTER TABLE $coursesTable ADD column $colLevel varchar(50)');
    }
  }

// Insert Operation: Insert a course object to database
  Future<int> insertCourse(Course course) async {
    Database db = await this.database;

    //db.rawInsert('insert into courses')

    // the long way and I have already have a course map
    // return db.insert(coursesTable, {
    //   colId: course.id,
    //   colName: course.name,
    //   colContent: course.content,
    //   colHours: course.hours,
    // });

    return db.insert(coursesTable, course.toMap());
  }

  Future<int> updateCourse(Course course) async {
    Database db = await this.database;

    return await db.update(coursesTable, course.toMap(),
        where: 'id = ?', whereArgs: [course.id]);
  }

// Select Operation: Get all course objects from database
  Future<List<Map<String, dynamic>>> getAllCourses() async {
    Database db = await this.database;
    //db.rawQuery("select * from courses")
    return db.query(coursesTable);
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteCourse(int id) async {
    var db = await this.database;
    // return  db.rawDelete('DELETE FROM $coursesTable WHERE $colId = $id');
    return db.delete(coursesTable, where: '$colId = ?', whereArgs: [id]);
    // return db.delete('courses', where: 'id = ?', whereArgs: [id]);
  }
}
