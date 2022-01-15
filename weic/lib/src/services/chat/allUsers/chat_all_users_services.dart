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

    List chatRoomsId = [];
    final chatRoomId =
        createRoomId(msg.senderId as String, msg.receiverId as String);
    final latestMensage = {
      'chatRoomId': chatRoomId,
      'timestamp': msg.timestamp,
      'mensage': mensage,
      'senderId': senderStudentId,
      'receiverId': msg.receiverId,
      'receiverName': msg.receiverName,
      'receiverProfilePhoto': msg.receiverPhoto,
    };

    var senderDataResponse = await _instance
        .collection('users')
        .doc(userCollectionDocID)
        .collection('students')
        .doc('student $senderStudentId')
        .get();
    if (senderDataResponse.exists) {
      print('senderStudentId: $senderStudentId');
      print('valueMsg: ${senderDataResponse.exists}');
      chatRoomsId = senderDataResponse.data()!['chatRoomIds'];
      if (!chatRoomsId.contains(chatRoomId)) {
        chatRoomsId.add(chatRoomId);
      }
    } else {
      chatRoomsId.add(chatRoomId);
    }

    await _instance
        .collection('users')
        .doc(userCollectionDocID)
        .collection('students')
        .doc('student ${msg.senderId}')
        .update({
      'chatRoomIds': chatRoomsId,
    });

    var receiverDataResponse = await _instance
        .collection('users')
        .doc(userCollectionDocID)
        .collection('students')
        .doc('student ${msg.receiverId}')
        .get();

    if (receiverDataResponse.exists) {
      print('senderStudentId: $senderStudentId');
      print('valueMsg: ${receiverDataResponse.exists}');
      chatRoomsId.length == 0 ? chatRoomsId = [] : chatRoomsId.clear();
      chatRoomsId = receiverDataResponse.data()!['chatRoomIds'];
      if (!chatRoomsId.contains(chatRoomId)) {
        chatRoomsId.add(chatRoomId);
      }
    } else {
      chatRoomsId.add(chatRoomId);
    }

    await _instance
        .collection('users')
        .doc(userCollectionDocID)
        .collection('students')
        .doc('student ${msg.receiverId}')
        .update({
      'chatRoomIds': chatRoomsId,
    });
    bool isThisChatRoomExists = await _instance
        .collection('chatRooms')
        .doc('$chatRoomsId')
        .snapshots()
        .isEmpty;
    if (isThisChatRoomExists) {
      await _instance
          .collection('chatRooms')
          .doc('$chatRoomsId')
          .update({'latestMensage': latestMensage});
    } else {
      await _instance
          .collection('chatRooms')
          .doc('$chatRoomsId')
          .set({'latestMensage': latestMensage});
    }
  }

  String createRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
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
