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
    required LatestMensage msg,
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
      'senderId':
          msg.senderId == senderStudentId ? msg.senderId : msg.receiverId,
      'receiverId':
          msg.receiverId == senderStudentId ? msg.receiverId : msg.senderId,
      'receiverName':
          msg.receiverId == senderStudentId ? msg.receiverName : msg.senderName,
      'receiverPhoto': msg.receiverId == senderStudentId
          ? msg.receiverProfilePhoto
          : msg.senderProfilePhoto,
      'receiverProfileVerified': msg.receiverId == senderStudentId
          ? msg.receiverProfileVerified
          : msg.senderProfileVerified,
    });

    List chatRoomsId = [];
    String? chatRoomId =
        createRoomId(msg.senderId as String, msg.receiverId as String);

    var senderDataResponse = await _instance
        .collection('users')
        .doc(userCollectionDocID)
        .collection('students')
        .doc(
            'student ${msg.senderId == senderStudentId ? msg.senderId : msg.receiverId}')
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
      'senderId': msg.senderId == senderStudentId ? sender.id : msg.receiverId,
      'chatRoomId': chatRoomId,
      'senderName':
          msg.senderId == senderStudentId ? sender.name : msg.receiverName,
      'timestamp': msg.timestamp,
      'receiverId':
          msg.senderId == senderStudentId ? msg.receiverId : sender.id,
      'receiverName':
          msg.senderId == senderStudentId ? msg.receiverName : sender.name,
      'senderProfilePhoto': msg.senderId == senderStudentId
          ? sender.profilePhoto
          : msg.receiverProfilePhoto,
      'receiverProfilePhoto': msg.senderId == senderStudentId
          ? msg.receiverProfilePhoto
          : sender.profilePhoto,
      'senderProfileVerified': msg.senderId == senderStudentId
          ? sender.isProfileVerified
          : msg.receiverProfileVerified,
      'receiverProfileVerified': msg.senderId == senderStudentId
          ? msg.receiverProfileVerified
          : sender.isProfileVerified,
    };

    await _instance
        .collection('users')
        .doc(userCollectionDocID)
        .collection('students')
        .doc(
            'student ${msg.senderId == senderStudentId ? msg.senderId : msg.receiverId}')
        .update({
      'chatRoomIds': chatRoomsId,
    });

    var receiverDataResponse = await _instance
        .collection('users')
        .doc(userCollectionDocID)
        .collection('students')
        .doc(
            'student ${msg.senderId == senderStudentId ? msg.receiverId : msg.senderId}')
        .get();

    if (receiverDataResponse.exists) {
      print('before clear:' + chatRoomsId.toString());
      chatRoomsId.length == 0 ? chatRoomsId = [] : chatRoomsId.clear();
      print('after clear:' + chatRoomsId.toString());
      chatRoomsId = receiverDataResponse.data()!['chatRoomIds'];
      if (!chatRoomsId.contains(chatRoomId)) {
        chatRoomsId.add(chatRoomId);
        print('after add value: ' + chatRoomsId.toString());
      }
    }

    await _instance
        .collection('users')
        .doc(userCollectionDocID)
        .collection('students')
        .doc(
            'student ${msg.senderId == senderStudentId ? msg.receiverId : msg.senderId}')
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
            .doc(chatRoomIds[i].toString())
            .get();
        print('chatRoomExists: ${chatRoomCollection.exists} and' +
            chatRoomIds[i].toString());
        if (chatRoomCollection.exists) {
          print(
              'chatRoomCollection: ${chatRoomCollection.data()!['latestMensage']}');
          latestMensages.add(LatestMensage.fromDocument(
              chatRoomCollection.data()!['latestMensage']));
          print(
              'after add value to latestMensage: ' + latestMensages.toString());
        }
      }
    }
    print('latestMensages: ${latestMensages.cast()}');
    return latestMensages;
  }
}
