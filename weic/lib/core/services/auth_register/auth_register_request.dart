import 'dart:async';

import '../../storage/db_storage.dart';
import '../../models/user.dart';

class RegisterRequest {
  DbStorage _dbStorage = DbStorage();
  Future<int> register(User user) async {
    final idUser = await _dbStorage.registerUser(user);
    return idUser;
  }
}
