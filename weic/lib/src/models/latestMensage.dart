import 'package:cloud_firestore/cloud_firestore.dart';

class LatestMensage {
  String? mensage;
  String? senderId;
  String? chatRoomId;
  String? receiverId;
  String? senderName;
  String? receiverName;
  Timestamp? timestamp;
  String? senderProfilePhoto;
  bool? senderProfileVerified;
  String? receiverProfilePhoto;
  bool? receiverProfileVerified;

  LatestMensage({
    required this.mensage,
    required this.senderId,
    required this.timestamp,
    required this.chatRoomId,
    required this.receiverId,
    required this.senderName,
    required this.receiverName,
    required this.senderProfilePhoto,
    required this.receiverProfilePhoto,
    required this.senderProfileVerified,
    required this.receiverProfileVerified,
  });

  factory LatestMensage.fromDocument(Map<String, dynamic> document) {
    return LatestMensage(
      mensage: document['mensage'],
      senderId: document['senderId'],
      timestamp: document['timestamp'],
      chatRoomId: document['chatRoomId'],
      receiverId: document['receiverId'],
      senderName: document['senderName'],
      receiverName: document['receiverName'],
      senderProfilePhoto: document['senderProfilePhoto'],
      receiverProfilePhoto: document['receiverProfilePhoto'],
      senderProfileVerified: document['senderProfileVerified'],
      receiverProfileVerified: document['receiverProfileVerified'],
    );
  }

  String toString() =>
      'latestMensage: $mensage, $senderId, $senderName, $receiverId, $receiverName';
}
