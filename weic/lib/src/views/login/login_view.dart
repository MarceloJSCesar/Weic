import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weic/src/models/student.dart';
import '../../config/app_colors.dart';
import '../../config/app_textstyles.dart';
import '../../config/app_decorations.dart';
import '../../config/app_assetsnames.dart';
import '../../components/login/body/login_body.dart';
import '../../controllers/login/login_controller.dart';
import '../../components/login/textfield/app_text_field_component.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _loginController = LoginController();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    listenUserLogChanges();
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: MediaQuery.of(context).size.height,
              decoration: AppDecorations.mainDecoration,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LoginBody(
                      formkey: _formKey,
                      login: () => login(
                          _emailController.text, _passwordController.text),
                      emailController: _emailController,
                      loginController: _loginController,
                      passwordController: _passwordController,
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          'Developed by Marcelo Cesar',
                          style: AppTextStyles.blackTextStyle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
