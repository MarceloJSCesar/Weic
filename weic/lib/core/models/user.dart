import 'package:weic/core/config/app_dbnames.dart';

class User {
  int id;
  String name;
  String school;

  User();

  User.fromMap(Map map) {
    id = map[AppDbNames.id];
    name = map[AppDbNames.name];
    school = map[AppDbNames.school];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      AppDbNames.name: name,
      AppDbNames.school: school
    };
    if (id != null) {
      map[AppDbNames.id] = id;
    }
    return map;
  }

  @override
  String toString() => 'User Data: id: $id, name: $name, school: $school';
}
