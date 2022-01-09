import 'package:cloud_firestore/cloud_firestore.dart';

class Mensage {
  Timestamp? timestamp;
  String? mensage;
  String? senderId;
  String? senderName;
  String? senderPhoto;
  bool? senderProfileVerified;
  String? receiverId;
  String? receiverName;
  String? receiverPhoto;
  bool? receiverProfileVerified;

  Mensage({
    required this.timestamp,
    required this.mensage,
    required this.senderId,
    required this.senderName,
    required this.senderPhoto,
    required this.senderProfileVerified,
    required this.receiverId,
    required this.receiverName,
    required this.receiverPhoto,
    required this.receiverProfileVerified,
  });

  factory Mensage.fromDocument(Map<String, dynamic> document) {
    return Mensage(
      timestamp: document['timestamp'],
      mensage: document['mensage'],
      senderId: document['senderId'],
      senderName: document['senderName'],
      senderPhoto: document['senderPhoto'],
      senderProfileVerified: document['senderProfileVerified'],
      receiverId: document['receiverId'],
      receiverName: document['receiverName'],
      receiverPhoto: document['receiverPhoto'],
      receiverProfileVerified: document['receiverProfileVerified'],
    );
  }
}
