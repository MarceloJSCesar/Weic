import 'package:shared_preferences/shared_preferences.dart';

class RegisterServices {
  Future saveCacheData(String email, String name) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.setString('NAME', name);
    await storage.setString('EMAIL', email);
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
