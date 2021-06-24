import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:weic/core/services/login_services.dart';
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
    print('userId: $userId');
    await LoginServices().saveUserId(userId);
    return userId;
  }

  Future<User> loginUser(User user) async {
    print("Select User");
    Database database = await db;
    List<Map> maps = await database.query(AppDbNames.storageTable,
        columns: [
          AppDbNames.email,
          AppDbNames.password,
        ],
        where: '${AppDbNames.email} = ? and ${AppDbNames.password} = ?',
        whereArgs: [user.email, user.password]);
    if (maps.length > 0) {
      return user;
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
    print(users);
    return users;
  }

  Future<User> getUser(int id) async {
    Database database = await db;
    List<Map> map = await database.query(AppDbNames.storageTable,
        columns: [
          AppDbNames.id,
          AppDbNames.email,
          AppDbNames.name,
          AppDbNames.school,
          AppDbNames.sexuality,
          AppDbNames.password
        ],
        where: '${AppDbNames.id} = ?',
        whereArgs: [id]);
    print('mapfirst: ${map.first}');
    if (map.length > 0) {
      return User.fromMap(map.first);
    } else {
      return null;
    }
  }
}
