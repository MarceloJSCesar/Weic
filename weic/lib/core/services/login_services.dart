import 'package:shared_preferences/shared_preferences.dart';

class LoginServices {
  Future<bool> saveCacheData(String email, String name) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    bool nameSaved = await storage.setString('NAME', name);
    bool idSaved = await storage.setString('EMAIL', email);
    if (nameSaved == true && idSaved == true) {
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
