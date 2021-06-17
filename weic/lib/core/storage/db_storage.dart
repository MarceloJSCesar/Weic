import 'dart:async';
import 'package:sqflite/sqflite.dart';
import '../storage/db.dart';
import '../models/user.dart';
import '../config/app_dbnames.dart';

class DbStorage {
  DatabaseHelper dbHelper = DatabaseHelper();
  Future<Database> get db => dbHelper.db;

  Future<User> loginUser(String name, String school) async {
    Database database = await db;
    List<Map<String, Object>> userData = await database.rawQuery(
        'SELECT * FROM ${AppDbNames.storageTable} WHERE name: $name and school: $school');
    if (userData.length > 0) {
      return User.fromMap(userData.first);
    } else {
      return null;
    }
  }

  Future<int> registerUser(User user) async {
    Database database = await db;
    int userId = await database.insert(
      AppDbNames.storageTable,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return userId;
  }

  Future<User> getUser(int id) async {
    Database database = await db;
    List<Map> maps = await database.query(AppDbNames.storageTable,
        columns: [
          AppDbNames.id,
          AppDbNames.img,
          AppDbNames.name,
          AppDbNames.school
        ],
        where: '${AppDbNames.id} = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> delete(int id) async {
    Database database = await db;
    return await database.delete(AppDbNames.storageTable,
        where: '${AppDbNames.id} = ?', whereArgs: [id]);
  }

  Future<List> getAllUsers() async {
    Database database = await db;
    List<Map> usersFound =
        await database.rawQuery('SELECT * FROM ${AppDbNames.storageTable}');
    List users = [];
    for (Map user in usersFound) {
      users.add(User.fromMap(user));
    }
    return users.cast();
  }
}
