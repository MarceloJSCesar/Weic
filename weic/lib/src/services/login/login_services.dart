import 'package:crypton/crypton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:weic/src/controllers/login/login_controller.dart';
import 'package:weic/src/models/post.dart';
import 'package:weic/src/models/student.dart';

class LoginServices {
  final _auth = LoginController();
  final uuid = Uuid();
  RSAKeypair rsaKeypair = RSAKeypair.fromRandom();
  Future<Student?> login(String? email, String? password) async {
    try {
      final _prefs = await SharedPreferences.getInstance();
      final studentID = _prefs.getString('STUDENT_ID') ?? null;
      UserCredential? _userCredential = await _auth.auth
          .signInWithEmailAndPassword(email: email!, password: password!);
      return Student(
        name: '',
        email: email,
        posts: <Post>[],
        profilePhoto: '',
        schoolName: 'ESAD',
        guests: <Student>[],
        followers: <Student>[],
        following: <Student>[],
        isMemberOfCFESAD:
            email == 'marcelobarbosa1511es3@gmail.com' ? true : false,
        password: rsaKeypair.publicKey.encrypt(password),
        id: studentID != null ? studentID : _userCredential.user!.uid,
        isProfileVerified:
            email == 'marcelobarbosa1511es3@gmail.com' ? true : false,
      );
    } on FirebaseException catch (errorMsg) {
      if (errorMsg.code == 'weak-password') {
        print('weak password');
      } else if (errorMsg.code == 'email-already-in-use') {
        print('email already in use');
      }
    }
  }

  void showLoginMsgError({required context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
        content: Text(
          'Usuário não encontrado',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  void saveLoginState(remenberMe) async {
    final _quickStoraged = await SharedPreferences.getInstance();
    await _quickStoraged.setBool('remenberMe', remenberMe);
  }

  void unsaveLoginState() async {
    final _quickStoraged = await SharedPreferences.getInstance();
    await _quickStoraged.remove('remenberMe');
  }

  Future<Map<String, dynamic>?> getLoginState() async {
    final _quickStoraged = await SharedPreferences.getInstance();
    bool remenberMe = _quickStoraged.getBool('remenberMe') ?? false;
    final studentID = _quickStoraged.getString('STUDENT_ID');
    final map = {'remenberMe': remenberMe, 'studentID': studentID};
    print('Map: ${map.cast()}');
    return map;
  }
}
