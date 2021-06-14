import 'package:weic/core/config/app_dbnames.dart';

class User {
  int? id;
  String? img;
  String? name;

  User.fromMap(Map map) {
    id = map[AppDbNames.id];
    img = map[AppDbNames.img];
    name = map[AppDbNames.name];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      AppDbNames.img: img,
      AppDbNames.name: name,
    };
    if (id != null) {
      map[AppDbNames.id] = id;
    }
    return map;
  }

  @override
  String toString() => 'User Data: id: $id, img: $img, name: $name';
}
