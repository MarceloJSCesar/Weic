import 'package:cloud_firestore/cloud_firestore.dart';

class LatestMensage {
  String? mensage;
  String? senderId;
  String? chatRoomId;
  String? receiverId;
  Timestamp? timestamp;
  String? receiverName;
  String? receiverProfilePhoto;
  bool? receiverProfileVerified;

  LatestMensage({
    required this.mensage,
    required this.senderId,
    required this.timestamp,
    required this.chatRoomId,
    required this.receiverId,
    required this.receiverName,
    required this.receiverProfilePhoto,
    required this.receiverProfileVerified,
  });

  factory LatestMensage.fromDocument(Map<String, dynamic> document) {
    return LatestMensage(
      mensage: document['mensage'],
      senderId: document['senderId'],
      timestamp: document['timestamp'],
      chatRoomId: document['chatRoomId'],
      receiverId: document['receiverId'],
      receiverName: document['receiverName'],
      receiverProfilePhoto: document['receiverProfilePhoto'],
      receiverProfileVerified: document['receiverProfileVerified'],
    );
  }
}
