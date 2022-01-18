import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weic/src/models/student.dart';

class StudentsServices {
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
}
