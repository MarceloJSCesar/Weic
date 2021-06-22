import 'dart:async';
import 'package:sqflite/sqflite.dart';
import '../storage/db.dart';
import '../models/user.dart';
import '../config/app_dbnames.dart';

class DbStorage {
  DatabaseHelper dbHelper = DatabaseHelper();
  Future<Database> get db => dbHelper.db;

  Future<int> registerUser(User user) async {
    Database database = await db;
    int userId = await database.insert(
      AppDbNames.storageTable,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return userId;
  }

  Future<User> loginUser(User user) async {
    print("Select User");
    print(user.id);
    print(user.name);
    print(user.school);
    Database database = await db;
    List<Map> maps = await database.query(AppDbNames.storageTable,
        columns: [
          AppDbNames.id,
          AppDbNames.email,
          AppDbNames.password,
        ],
        where: '${AppDbNames.email} = ? and ${AppDbNames.password} = ?',
        whereArgs: [user.email, user.password]);
    if (maps.length > 0) {
      print('user exist');
      return user;
    } else {
      return null;
    }
  }

  Future<int> delete(User user) async {
    Database database = await db;
    return await database.delete(AppDbNames.storageTable,
        where: '${AppDbNames.id} = ?', whereArgs: [user.id]);
  }

  Future<List> getAllUsers() async {
    Database database = await db;
    List<Map> usersFound =
        await database.rawQuery('SELECT * FROM ${AppDbNames.storageTable}');
    List users = [];
    for (Map user in usersFound) {
      users.add(User.fromMap(user));
    }
    return users;
  }
}
