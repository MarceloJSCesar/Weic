import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user.dart';
import '../config/app_dbnames.dart';

class DbStorage {
  static final DbStorage _instance = DbStorage.internal();
  factory DbStorage() => _instance;
  DbStorage.internal();

  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'weiceStorage.db');

    return await openDatabase(path, version: 1,
        onCreate: (dataB, newVersion) async {
      await dataB.execute(
          'CREATE TABLE ${AppDbNames.storageTable}(${AppDbNames.id} INTEGER PRIMARY KEY, ${AppDbNames.img} TEXT, ${AppDbNames.name} TEXT)');
    });
  }

  Future<User> insert(User user) async {
    Database database = await db;
    user.id = await database.insert(
      AppDbNames.storageTable,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return user;
  }

  Future<User> getUser(int id) async {
    Database database = await db;
    List<Map> maps = await database.query(AppDbNames.storageTable,
        columns: [
          AppDbNames.id,
          AppDbNames.img,
          AppDbNames.name,
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

  Future<List> getAllContacts() async {
    Database dbContact = await db;
    List listMap =
        await dbContact.rawQuery("SELECT * FROM ${AppDbNames.storageTable}");
    List<User> listUser = [];
    for (Map m in listMap) {
      listUser.add(User.fromMap(m));
    }
    return listUser;
  }
}
