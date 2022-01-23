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
  }) async {
    List<Student> _students = [];
    await _instance
        .collection('users')
        .doc(userCollectionDocID)
        .collection('students')
        .where('schoolYear', isLessThanOrEqualTo: schoolYear)
        .get()
        .then((value) => value.docs.isNotEmpty
            ? value.docs.forEach((element) {
                print('element:' + element.data().toString());
                _students.add(Student.fromDocument(element.data()));
              })
            : null);
    return _students;
  }
}
