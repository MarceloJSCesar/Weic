import 'dart:async';

import '../../models/user.dart';
import '../../storage/db_storage.dart';

class LoginRequest {
  DbStorage _dbStorage = DbStorage();
  Future<User> login(String name, String school) async {
    User user = await _dbStorage.loginUser(name, school);
    return user;
  }
}
