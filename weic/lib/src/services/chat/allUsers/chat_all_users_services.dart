import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:weic/src/models/mensage.dart';
import 'package:weic/src/models/student.dart';

class ChatAllUsersService {
  final _instance = FirebaseFirestore.instance;
  final String userCollectionDocID = '-1-2-22-weic-MarceloCesar-';

  Future<List<Student>>? getAllStudents() async {
    var studentIDResponse =
        await _instance.collection('generalUsers').doc('GENERAL-USERS').get();
    List studentsID = studentIDResponse.data()!['users'];
    List<Student> students = [];
    for (int i = 0; i < studentsID.length; i++) {
      var studentDataResponse = await _instance
          .collection('users')
          .doc(userCollectionDocID)
          .collection('students')
          .doc('student ${studentsID[i]}')
          .get();
      students.add(Student.fromDocument(
        studentDataResponse.data(),
      ));
    }
    return students;
  }

  Future sendPrivateMessage({
    required String mensage,
    required String senderStudentId,
    required Mensage msg,
  }) async {
    await _instance
        .collection('mensages')
        .doc('MENSAGENS')
        .collection('private')
        .doc('PRIVATE')
        .collection('private-mensagens')
        .doc('PRIVATE-MENSAGENS')
        .collection('message')
        .add({
      'mensage': mensage,
      'timestamp': msg.timestamp,
      'senderId': senderStudentId,
      'receiverId': msg.receiverId,
      'receiverName': msg.receiverName,
      'receiverPhoto': msg.receiverPhoto,
      'receiverProfileVerified': msg.receiverProfileVerified,
    });
    Map<String, dynamic>? mensages = {};
    final newMsg = {
      'timestamp': msg.timestamp,
      'mensage': mensage,
      'senderId': senderStudentId,
      'receiverId': msg.receiverId,
      'receiverName': msg.receiverName,
      'receiverProfilePhoto': msg.receiverPhoto,
    };
  }

  Future getPrivateMessages({required String myId}) async {
    var privateMessagesResponse = await _instance
        .collection('mensages')
        .doc('MENSAGENS')
        .collection('private')
        .doc('PRIVATE')
        .collection('private-mensagens')
        .doc('PRIVATE-MENSAGENS')
        .collection('message')
        .get();
    if (privateMessagesResponse.docs.isNotEmpty) {
      return privateMessagesResponse.docs.map(
        (mensages) {
          Mensage mensage = Mensage.fromDocument(mensages.data());
          print('function get mensagem: ${mensage.toString()}');
        },
      ).toList();
    } else {
      return null;
    }
  }
}
