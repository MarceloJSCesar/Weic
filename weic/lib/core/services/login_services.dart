import 'package:shared_preferences/shared_preferences.dart';

class LoginServices {
  Future saveCacheData(String email, String password) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    bool emailSaved = await storage.setString('EMAIL', email);
    bool passwordSaved = await storage.setString('PASSWORD', password);
    if (emailSaved == true && passwordSaved == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteCacheData() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    bool nameDeleted = await storage.remove('NAME');
    bool idRemoved = await storage.remove('EMAIL');
    if (nameDeleted == true && idRemoved == true) {
      return true;
    } else {
      return false;
    }
  }
}
