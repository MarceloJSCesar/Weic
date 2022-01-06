import 'package:cloud_firestore/cloud_firestore.dart';

class ChatAllUsersService {
  final _instance = FirebaseFirestore.instance;

  Future getAllStudents() async {
    return await _instance.collection('users').where('posts').get();
  }
}
