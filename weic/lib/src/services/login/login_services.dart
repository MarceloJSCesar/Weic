import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../models/student.dart';

class LoginServices {
  FirebaseAuth _auth = FirebaseAuth.instance;
  void listenUserLogChanges() {
    _auth.authStateChanges().listen((user) {
      if (user == null) {
        print('user is logged out');
      } else {
        print('user is logged in');
      }
    });
  }

  Future<Student?> login(String? email, String? password) async {
    try {
      UserCredential? _userCredential = await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      return Student(
          name: _userCredential.user!.displayName,
          email: email,
          password: password);
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
}
