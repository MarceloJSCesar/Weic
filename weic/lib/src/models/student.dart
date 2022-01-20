import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Student {
  String? id;
  List? posts;
  List? guests;
  String? name;
  String? email;
  List? following;
  List? followers;
  String? password;
  List? chatRoomIds;
  String? schoolName;
  String? schoolYear;
  String? profilePhoto;
  bool? isMemberOfCFESAD;
  bool? isProfileVerified;

  Student({
    this.id,
    this.name,
    this.posts,
    this.email,
    this.guests,
    this.password,
    this.followers,
    this.following,
    this.schoolName,
    this.schoolYear,
    this.chatRoomIds,
    this.profilePhoto,
    this.isMemberOfCFESAD = false,
    this.isProfileVerified = false,
  });

  dynamic toJson() => {
        'id': id,
        'name': name,
        'posts': posts,
        'email': email,
        'guests': guests,
        'password': password,
        'followers': followers,
        'following': following,
        'schoolName': schoolName,
        'schoolYear': schoolYear,
        'chatRoomIds': chatRoomIds,
        'profilePhoto': profilePhoto,
        'isMemberOfCFESAD': isMemberOfCFESAD,
        'isProfileVerified': isProfileVerified,
      };

  factory Student.fromSnapshot(AsyncSnapshot document) {
    return Student(
      id: document.data['id'],
      name: document.data['name'],
      posts: document.data['posts'],
      email: document.data['email'],
      guests: document.data['guests'],
      password: document.data['password'],
      followers: document.data['followers'],
      following: document.data['following'],
      schoolName: document.data['schoolName'],
      schoolYear: document.data['schoolYear'],
      chatRoomIds: document.data['chatRoomIds'],
      profilePhoto: document.data['profilePhoto'],
      isMemberOfCFESAD: document.data['isMemberOfCFESAD'],
      isProfileVerified: document.data['isProfileVerified'],
    );
  }

  factory Student.fromDocument(Map<String, dynamic>? document) {
    return Student(
      id: document!['id'],
      name: document['name'],
      posts: document['posts'],
      email: document['email'],
      guests: document['guests'],
      password: document['password'],
      followers: document['followers'],
      following: document['following'],
      schoolName: document['schoolName'],
      schoolYear: document['schoolYear'],
      chatRoomIds: document['chatRoomIds'],
      profilePhoto: document['profilePhoto'],
      isMemberOfCFESAD: document['isMemberOfCFESAD'],
      isProfileVerified: document['isProfileVerified'],
    );
  }

  @override
  String toString() {
    return 'Student{id: $id, name: $name, posts: $posts, email: $email, guests: $guests, password: $password, followers: $followers, following: $following, schoolName: $schoolName, schoolYear: $schoolYear, chatRoomIds: $chatRoomIds, profilePhoto: $profilePhoto, isMemberOfCFESAD: $isMemberOfCFESAD, isProfileVerified: $isProfileVerified}';
  }
}
