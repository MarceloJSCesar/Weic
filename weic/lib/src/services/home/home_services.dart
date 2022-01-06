// api = https://newsapi.org/v2/top-headlines?sources=google-news-br&apiKey=198fc078a1cf4c17bf5a70678ffa3e68
// api2 = https://eco.sapo.pt/wp-json/eco/v1/items

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:weic/src/models/student.dart';
import 'dart:convert';
import '../../models/news.dart';

class HomeServices {
  final String userCollectionDocID = '-1-2-22-weic-MarceloCesar-';
  Future getSapoNews() async {
    final sapoApi = Uri.parse('https://eco.sapo.pt/wp-json/eco/v1/items');
    http.Response response = await http.get(sapoApi);
    if (response.statusCode == 200) {
      print('has a data');
      final data = json.decode(response.body);
      return data;
    } else {
      print('no data received');
      return null;
    }
  }

  Future sendEssentialStudentDataToFirebase({required Student student}) async {
    List? body;
    var _instance = FirebaseFirestore.instance;
    await _instance
        .collection('users')
        .doc(userCollectionDocID)
        .collection('students')
        .doc('student ${student.id}')
        .set(student.toJson())
        .then((value) => print('success'))
        .catchError((errorMsg) => print('errorMsg: $errorMsg'));
    await _instance
        .collection('generalUsers')
        .doc('GENERAL-USERS')
        .get()
        .then((value) {
      var data = value.data();
      body = data!['users'];
      print(body.toString());
      body!.add(student.id);
      print('body after: ${body.toString()}');
    });
    await _instance.collection('generalUsers').doc('GENERAL-USERS').update(
      {'users': body},
    );
  }

  Future getStudentEssentialData({required String studentID}) async {
    var _studentCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userCollectionDocID)
        .collection('students')
        .doc('student $studentID');
    final data = await _studentCollection.get();
    return data.exists ? data.data() : null;
  }
}
