import 'dart:async';

import '../../models/user.dart';
import '../../storage/db_storage.dart';

class LoginRequest {
  Future<User> login(String email, String password) async {
    User user = new User(
      email: email,
      name: null,
      password: password,
      school: null,
      sexuality: null,
    );
    DbStorage _dbStorage = DbStorage();
    User userResult = new User(
      email: null,
      name: null,
      password: null,
      school: null,
      sexuality: null,
    );
    userResult = await _dbStorage.loginUser(user);
    if (userResult != null) {
      return Future.value(
        User(
          email: email,
          password: password,
          id: null,
          name: null,
          school: null,
          sexuality: null,
        ),
      );
    } else {
      print('not well done');
      return null;
    }
  }
}
