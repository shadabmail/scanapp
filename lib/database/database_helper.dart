import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/asset_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('assets.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE assets (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        qrId TEXT NOT NULL,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        summary TEXT,
        imagePath TEXT NOT NULL,
        createdAt TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertAsset(Asset asset) async {
    final db = await database;
    return await db.insert('assets', asset.toMap());
  }

  Future<List<Asset>> getAllAssets() async {
    final db = await database;
    final result = await db.query('assets', orderBy: 'createdAt DESC');
    return result.map((map) => Asset.fromMap(map)).toList();
  }

  Future<Asset?> getAssetById(int id) async {
    final db = await database;
    final result = await db.query('assets', where: 'id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return Asset.fromMap(result.first);
    }
    return null;
  }

  Future<int> deleteAsset(int id) async {
    final db = await database;
    return await db.delete('assets', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
