import 'package:shared_preferences/shared_preferences.dart';

class RegisterServices {
  Future<bool> saveCacheData(int id, String name) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    bool nameSaved = await storage.setString('NAME', name);
    bool idSaved = await storage.setInt('ID', id);
    if (nameSaved == true && idSaved == true) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteCacheData() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    bool nameDeleted = await storage.remove('NAME');
    bool idRemoved = await storage.remove('ID');
    if (nameDeleted == true && idRemoved == true) {
      return true;
    } else {
      return false;
    }
  }
}
