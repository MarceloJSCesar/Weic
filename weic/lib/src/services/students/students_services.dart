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

  Future followStudent({
    required String studentID,
    required String myID,
  }) async {
    try {
      await _instance
          .collection('users')
          .doc(userCollectionDocID)
          .collection('students')
          .doc('student $studentID')
          .update({
        'followers': FieldValue.arrayUnion([myID]),
      });
      await _instance
          .collection('users')
          .doc(userCollectionDocID)
          .collection('students')
          .doc('student $myID')
          .update({
        'following': FieldValue.arrayUnion([studentID]),
      });
    } catch (error) {
      print('Error on followStudent: $error');
      return null;
    }
  }

  Future unfollowStudent({
    required String studentID,
    required String myID,
  }) async {
    try {
      List _followers = [];
      List _following = [];
      // to get the followers list and remove the myID
      await _instance
          .collection('users')
          .doc(userCollectionDocID)
          .collection('students')
          .doc('student $studentID')
          .get()
          .then(
        (value) {
          _followers = value.data()!['followers'] as List;
          print('Not me: _followers: $_followers');
          _followers.remove(myID);
          print('Not me: after removing myID, _followers: $_followers');
        },
      );
      await _instance
          .collection('users')
          .doc(userCollectionDocID)
          .collection('students')
          .doc('student $studentID')
          .update(
        {
          'followers': _followers,
        },
      );
      // to get the following list and remove the studentID
      await _instance
          .collection('users')
          .doc(userCollectionDocID)
          .collection('students')
          .doc('student $myID')
          .get()
          .then(
        (value) {
          _following = value.data()!['following'] as List;
          print('Me: _following: $_following');
          _following.remove(studentID);
          print('Me: after removing studentID, _following: $_following');
        },
      );
      await _instance
          .collection('users')
          .doc(userCollectionDocID)
          .collection('students')
          .doc('student $myID')
          .update(
        {
          'following': _following,
        },
      );
    } catch (error) {
      print('Error on followStudent: $error');
      return null;
    }
  }

  Future visitingStudentProfile(
      {required String studentID, required String myID}) async {
    try {
      await _instance
          .collection('users')
          .doc(userCollectionDocID)
          .collection('students')
          .doc('student $studentID')
          .update({
        'guests': FieldValue.arrayUnion([myID]),
      });
    } catch (error) {
      print('Error on visitingStudentProfile: $error');
      return null;
    }
  }
}
