import 'package:shared_preferences/shared_preferences.dart';

class LoginServices {
  Future saveUserIdAndEmail(int userId, String email) async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    await cache.setInt('UserID', userId);
    await cache.setString('UserEmail', email);
  }

  Future saveUserEmail(String email) async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    await cache.setString('UserEmail', email);
  }

  Future<int> getUserId() async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    int userId = cache.getInt('UserID');
    print('getid: $userId');
    return userId;
  }

  Future<String> getUserEmail() async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    String userEmail = cache.getString('UserEmail');
    print('getEmail: $userEmail');
    return userEmail;
  }

  Future logout() async {
    SharedPreferences cache = await SharedPreferences.getInstance();
    await cache.remove('UserEmail');
  }
}
