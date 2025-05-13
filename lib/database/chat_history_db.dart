import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class ChatHistoryDB {
  static final ChatHistoryDB _instance = ChatHistoryDB._internal();
  factory ChatHistoryDB() => _instance;
  ChatHistoryDB._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("chat_history.db");
    return _database!;
  }

  //Initializes the database and returns the database instance
  Future<Database> _initDB(String fileName) async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = join(documentsDir.path, fileName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // create this history table
  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        session INTEGER NOT NULL,
        message TEXT NOT NULL,
        role TEXT NOT NULL,
        timestamp TEXT NOT NULL
      )
    ''');
  }

  // insert a new chat entry into the history table
  Future<void> insertHistory(String message, DateTime timestamp, String role, int session) async {
    final db = await database;
    await db.insert('history', {
      'session': session,
      'message': message,
      'role': role,
      'timestamp': timestamp.toIso8601String(),
    });
  }

  // sort from newest to oldest
  Future<List<Map<String, dynamic>>> fetchHistory() async {
    final db = await database;
    return await db.rawQuery("SELECT * FROM history WHERE id IN (SELECT MIN(id) FROM history GROUP BY session)");
  }

  Future<List<Map<String, dynamic>>> fetchMessage(int sessionID) async {
    final db = await database;
    return await db.query("history", where: "session = ?", whereArgs: [sessionID]);
  }

  Future<void> clearAll() async {
    final db = await database;
    await db.delete('history');
  }
}