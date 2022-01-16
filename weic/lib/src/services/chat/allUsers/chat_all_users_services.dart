import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:weic/src/models/latestMensage.dart';
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
    String? chatRoomId =
        createRoomId(msg.senderId as String, msg.receiverId as String);

    var senderDataResponse = await _instance
        .collection('users')
        .doc(userCollectionDocID)
        .collection('students')
        .doc('student $senderStudentId')
        .get();
    if (senderDataResponse.exists) {
      chatRoomsId = senderDataResponse.data()!['chatRoomIds'];
      if (!chatRoomsId.contains(chatRoomId)) {
        chatRoomsId.add(chatRoomId);
      }
    }

    Student sender = Student.fromDocument(senderDataResponse.data());

    final latestMensage = {
      'mensage': mensage,
      'chatRoomId': chatRoomId,
      'senderName': sender.name,
      'timestamp': msg.timestamp,
      'senderId': senderStudentId,
      'receiverId': msg.receiverId,
      'receiverName': msg.receiverName,
      'senderProfilePhoto': sender.profilePhoto,
      'receiverProfilePhoto': msg.receiverPhoto,
      'senderProfileVerified': sender.isProfileVerified,
      'receiverProfileVerified': msg.receiverProfileVerified,
    };

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
      print('before clear:' + chatRoomsId.toString());
      chatRoomsId.length == 0 ? chatRoomsId = [] : chatRoomsId.clear();
      print('after clear:' + chatRoomsId.toString());
      chatRoomsId = receiverDataResponse.data()!['chatRoomIds'];
      print('after add value: ' + chatRoomsId.toString());
      if (!chatRoomsId.contains(chatRoomId)) {
        chatRoomsId.add(chatRoomId);
      }
    }

    await _instance
        .collection('users')
        .doc(userCollectionDocID)
        .collection('students')
        .doc('student ${msg.receiverId}')
        .update({
      'chatRoomIds': chatRoomsId,
    });
    chatRoomsId.forEach((chatRoomID) async {
      bool isThisChatRoomExists = await _instance
          .collection('chatRooms')
          .doc('$chatRoomID')
          .snapshots()
          .isEmpty;
      if (isThisChatRoomExists) {
        await _instance
            .collection('chatRooms')
            .doc('$chatRoomID')
            .update({'latestMensage': latestMensage});
      } else {
        await _instance
            .collection('chatRooms')
            .doc('$chatRoomID')
            .set({'latestMensage': latestMensage});
      }
    });
  }

  String createRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Future<List<LatestMensage>>? getPrivateMessages(
      {required String myId}) async {
    List? chatRoomIds;
    List<LatestMensage> latestMensages = [];
    var studentData = await _instance
        .collection('users')
        .doc(userCollectionDocID)
        .collection('students')
        .doc('student $myId')
        .get();
    if (studentData.exists) {
      chatRoomIds = studentData.data()!['chatRoomIds'];
      print('chatRoomIdss: ${chatRoomIds!.cast()}');
      for (int i = 0; i < chatRoomIds.length; i++) {
        var chatRoomCollection = await _instance
            .collection('chatRooms')
            .doc('[${chatRoomIds[i]}]')
            .get();
        print('chatRoomExists: ${chatRoomCollection.exists} and $i');
        if (chatRoomCollection.exists) {
          print(
              'chatRoomCollection: ${chatRoomCollection.data()!['latestMensage']}');
          latestMensages.add(LatestMensage.fromDocument(
              chatRoomCollection.data()!['latestMensage']));
        }
      }
    }
    print('latestMensages: ${latestMensages.cast()}');
    return latestMensages;
  }
}
