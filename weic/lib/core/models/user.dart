import 'package:weic/core/config/app_dbnames.dart';

class User {
  int id;
  String name;
  String email;
  String school;
  String sexuality;
  String password;

  User({
    this.id,
    this.email,
    this.name,
    this.school,
    this.sexuality,
    this.password,
  });

  User.fromMap(Map map) {
    id = map[AppDbNames.id];
    name = map[AppDbNames.name];
    school = map[AppDbNames.school];
    password = map[AppDbNames.password];
    sexuality = map[AppDbNames.sexuality];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      AppDbNames.name: name,
      AppDbNames.email: email,
      AppDbNames.school: school,
      AppDbNames.sexuality: sexuality,
      AppDbNames.password: password
    };
    if (id != null) {
      map[AppDbNames.id] = id;
    }
    return map;
  }

  @override
  String toString() =>
      'User Data: id: $id, email: $email, password: $password, name: $name, school: $school, sexuality: $sexuality';
}
