import 'package:cloud_firestore/cloud_firestore.dart';
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
    required Student senderStudent,
    required Student receiverStudent,
  }) async {
    final _instance = FirebaseFirestore.instance;
    await _instance
        .collection('mensages')
        .doc('MENSAGENS')
        .collection('private')
        .doc('PRIVATE')
        .collection(senderStudent.name as String)
        .doc(senderStudent.id)
        .collection('message')
        .add({
      'mensage': mensage,
      'timestamp': Timestamp.now(),
      'senderId': senderStudent.id,
      'senderName': senderStudent.name,
      'senderPhoto': senderStudent.profilePhoto,
      'senderProfileVerified': senderStudent.isProfileVerified,
      'receiverId': receiverStudent.id,
      'receiverName': receiverStudent.name,
      'receiverPhoto': receiverStudent.profilePhoto,
      'receiverProfileVerified': receiverStudent.isProfileVerified,
    });
  }
}
