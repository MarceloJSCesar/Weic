import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  String? id;
  String? name;
  String? email;
  String? password;
  String? schoolName;

  Student({
    this.id,
    this.name,
    this.email,
    this.password,
    this.schoolName,
  });

  dynamic toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'schoolName': schoolName,
      };

  factory Student.fromDocument(DocumentSnapshot document) {
    return Student(
      id: document['id'],
      name: document['name'],
      email: document['email'],
      password: document['password'],
      schoolName: document['schoolName'],
    );
  }

  @override
  String toString() {
    return 'Student{id: $id, name: $name, email: $email, password: $password, schoolName: $schoolName}';
  }
}
