import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE students (
        id   INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE exams (
        id        INTEGER PRIMARY KEY AUTOINCREMENT,
        exam_name TEXT NOT NULL
      )
    ''');
  }

  // ─── Students ────────────────────────────────────────────────────────────

  Future<int> insertStudent(String name) async {
    final db = await database;
    return db.insert('students', {'name': name});
  }

  Future<List<Map<String, dynamic>>> getStudents() async {
    final db = await database;
    return db.query('students', orderBy: 'id ASC');
  }

  Future<int> updateStudent(int id, String newName) async {
    final db = await database;
    return db.update(
      'students',
      {'name': newName},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteStudent(int id) async {
    final db = await database;
    return db.delete('students', where: 'id = ?', whereArgs: [id]);
  }

  // ─── Exams ────────────────────────────────────────────────────────────────

  Future<int> insertExam(String examName) async {
    final db = await database;
    return db.insert('exams', {'exam_name': examName});
  }

  Future<List<Map<String, dynamic>>> getExams() async {
    final db = await database;
    return db.query('exams', orderBy: 'id ASC');
  }

  Future<int> updateExam(int id, String newName) async {
    final db = await database;
    return db.update(
      'exams',
      {'exam_name': newName},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteExam(int id) async {
    final db = await database;
    return db.delete('exams', where: 'id = ?', whereArgs: [id]);
  }
}