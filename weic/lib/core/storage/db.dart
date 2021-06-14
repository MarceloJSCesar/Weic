import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user.dart';
import '../config/app_dbnames.dart';

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

  Future<User> insert(User user) async {
    final database = await db;
    // later take a look to let student when register with same name that will fail , to change name instead
    user.id = await database?.insert(
      AppDbNames.storageTable,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return user;
  }

  Future<User?> getUser(int? id) async {
    Database? database = await db;
    dynamic maps = await database?.query(
      AppDbNames.storageTable,
      columns: [
        AppDbNames.id,
        AppDbNames.img,
        AppDbNames.name,
      ],
      where: '${AppDbNames.id} = ?',
      whereArgs: [AppDbNames.id],
    );
    if (maps.length > 0) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int?> delete(int id) async {
    Database? database = await db;
    return await database?.delete(AppDbNames.storageTable,
        where: '${AppDbNames.id} = ?', whereArgs: [AppDbNames.id]);
  }
}
