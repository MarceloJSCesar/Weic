import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weic/src/models/student.dart';

class StudentsServices {
  final _instance = FirebaseFirestore.instance;
  final String userCollectionDocID = '-1-2-22-weic-MarceloCesar-';

  /*
    I think getAllStudents is not necessary, 
    because user will search students by the school year and 
    show all the students according to their school year
  */
  Future<List<Student>> getUserBySchoolYear({
    required String schoolYear,
    required String myID,
  }) async {
    List<Student> _students = [];
    await _instance
        .collection('users')
        .doc(userCollectionDocID)
        .collection('students')
        .where('schoolYear', isEqualTo: schoolYear)
        .get()
        .then((value) => value.docs.isNotEmpty
            ? value.docs.forEach((element) {
                _students.add(Student.fromDocument(element.data()));
              })
            : null);
    for (int i = 0; i < _students.length; i++) {
      if (_students[i].id == myID) {
        _students.removeAt(i);
      }
    }
    return _students.length > 0 ? _students : null as List<Student>;
  }
}
