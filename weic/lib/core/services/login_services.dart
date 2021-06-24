import 'package:shared_preferences/shared_preferences.dart';

class LoginServices {
  Future saveUserId(int userId) async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    await cache.setInt('UserID', userId);
  }

  Future<int> getUserId() async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    int userId = cache.getInt('UserID');
    print('getid: $userId');
    return userId;
  }
}
