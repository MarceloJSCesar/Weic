import 'package:weic/core/config/app_dbnames.dart';

class User {
  int? id;
  String? name;

  User({
    this.id,
    this.name,
  });

  User.fromMap(Map map) {
    id = map[AppDbNames.id];
    name = map[AppDbNames.name];
  }

  Map? toMap() {
    Map<String, dynamic> map = {
      AppDbNames.name: name,
    };
    if (id != null) {
      map[AppDbNames.id] = id;
    }
    return map;
  }
}
