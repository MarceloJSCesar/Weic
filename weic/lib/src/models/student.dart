import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Student {
  String? id;
  String? name;
  String? email;
  String? password;
  String? schoolName;
  String? profilePhoto;
  bool? isMemberOfCFESAD;
  bool? isProfileVerified;
  List<Student>? following;
  List<Student>? followers;

  Student({
    this.id,
    this.name,
    this.email,
    this.password,
    this.followers,
    this.following,
    this.schoolName,
    this.profilePhoto,
    this.isMemberOfCFESAD,
    this.isProfileVerified,
  });

  dynamic toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'password': password,
        'followers': followers,
        'following': following,
        'schoolName': schoolName,
        'profilePhoto': profilePhoto,
        'isMemberOfCFESAD': isMemberOfCFESAD,
        'isProfileVerified': isProfileVerified,
      };

  factory Student.fromSnapshot(AsyncSnapshot document) {
    return Student(
      id: document.data['id'],
      name: document.data['name'],
      email: document.data['email'],
      password: document.data['password'],
      followers: document.data['followers'],
      following: document.data['following'],
      schoolName: document.data['schoolName'],
      profilePhoto: document.data['profilePhoto'],
      isMemberOfCFESAD: document.data['isMemberOfCFESAD'],
      isProfileVerified: document.data['isProfileVerified'],
    );
  }

  factory Student.fromDocument(Map<String, dynamic>? document) {
    return Student(
      id: document!['id'],
      name: document['name'],
      email: document['email'],
      password: document['password'],
      followers: document['followers'],
      following: document['following'],
      schoolName: document['schoolName'],
      profilePhoto: document['profilePhoto'],
      isMemberOfCFESAD: document['isMemberOfCFESAD'],
      isProfileVerified: document['isProfileVerified'],
    );
  }

  @override
  String toString() {
    return 'Student{id: $id, name: $name, email: $email, password: $password, schoolName: $schoolName, profilePhoto: $profilePhoto}';
  }
}
