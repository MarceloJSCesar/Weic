import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weic/src/controllers/login/login_controller.dart';

class LoginServices {
  final _auth = LoginController();

  Future<Map?> login(String? email, String? password) async {
    try {
      UserCredential? _userCredential = await _auth.auth
          .signInWithEmailAndPassword(email: email!, password: password!);
      return {
        'email': email,
        'password': password,
        'name': _userCredential.user!.displayName,
      };
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

  Future<bool> getLoginState() async {
    final _quickStoraged = await SharedPreferences.getInstance();
    final remenberMe = _quickStoraged.getBool('remenberMe');
    return remenberMe!;
  }
}
