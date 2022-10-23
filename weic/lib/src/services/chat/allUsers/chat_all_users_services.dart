import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weic/src/models/latestMensage.dart';
import 'package:weic/src/models/mensage.dart';

class ChatAllUsersService {
  final _instance = FirebaseFirestore.instance;
  final String userCollectionDocID = '-1-2-22-weic-MarceloCesar-';

  Future sendFirstPrivateMessage({
    required String mensage,
    required Mensage msg,
  }) async {
    try {
      // final String chatRoomId =
      //     createChatRoomId(msg.senderId as String, msg.receiverId as String);
      // await createChatRoomCollection(chatRoomId: msg as String);
      // final Map<String, dynamic> message = {
      //   'message': msg.mensage,
      //   'senderId': msg.senderId,
      //   'chatRoomId': chatRoomId,
      //   'timestamp': msg.timestamp,
      //   'receiverId': msg.receiverId,
      //   'receiverProfilePhoto': msg.receiverPhoto,
      //   'isReceiverProfileVerified': msg.receiverProfileVerified,
      // };
      await _instance
          .collection('users')
          .doc(userCollectionDocID)
          .collection('students')
          .doc('student ${msg.senderId}')
          .get()
          .then((data) {
        print(
            'chatRoomIds from user collection: ' + data.data()!['chatRoomIds']);
      });
    } catch (errormsg) {
      print('errormsg: $errormsg');
    }
  }

  Future sendPrivateMessage({
    required String mensage,
    required String senderStudentId,
    required LatestMensage msg,
    required String receiverStudentId,
  }) async {
    try {
      // final Map<String, dynamic> message = {
      //   'timestamp': msg.timestamp,
      //   'senderId': msg.senderId,
      //   'receiverId': msg.receiverId,
      //   'isReceiverProfileVerified': msg.receiverProfileVerified,
      //   'receiverProfilePhoto': msg.receiverProfilePhoto,
      //   'message': msg.mensage,
      //   'chatRoomId': msg.chatRoomId,
      // };
    } catch (errormsg) {
      print('errormsg: $errormsg');
    }
  }

  Future createChatRoomCollection({
    required String chatRoomId,
  }) async {
    return _instance.collection('ChatRoom').doc(chatRoomId);
  }

  String createChatRoomId(String firstsender, String firstreceiver) {
    if (firstsender.substring(0, 1).codeUnitAt(0) >
        firstreceiver.substring(0, 1).codeUnitAt(0)) {
      return "$firstreceiver\_$firstsender";
    } else {
      return "$firstsender\_$firstreceiver";
    }
  }

  Future<List<LatestMensage>>? getPrivateMessages(
      {required String myId}) async {
    List<LatestMensage> latestMensages = [];
    return latestMensages;
  }
}
