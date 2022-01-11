import 'package:cloud_firestore/cloud_firestore.dart';

class Mensage {
  Timestamp? timestamp;
  String? mensage;
  String? senderId;
  String? receiverId;
  String? receiverName;
  String? receiverPhoto;
  bool? receiverProfileVerified;

  Mensage({
    required this.timestamp,
    required this.mensage,
    required this.senderId,
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
      receiverId: document['receiverId'],
      receiverName: document['receiverName'],
      receiverPhoto: document['receiverPhoto'],
      receiverProfileVerified: document['receiverProfileVerified'],
    );
  }
}
