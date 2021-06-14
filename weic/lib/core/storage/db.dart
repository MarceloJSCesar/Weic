import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weic/core/config/app_dbnames.dart';

class DbStorage {
  DbStorage.internal();
  static final DbStorage _instance = DbStorage.internal();
  factory DbStorage() => _instance;

  Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'storage.db');

    return await openDatabase(path, version: 1,
        onCreate: (Database database, int newereVersion) async {
      await database.execute(
          'CREATE TABLE ${AppDbNames.storageTable}(${AppDbNames.id} INTEGER PRIMARY KEY, ${AppDbNames.name} TEXT, ${AppDbNames.img} TEXT)');
    });
  }
}
