import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../config/app_textstyle.dart';
import '../../components/login/login_field.dart';
import '../../components/login/logo_image.dart';
import '../../controllers/login/login_controller.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController _loginController = LoginController();
  final _emailFormkey = GlobalKey<FormState>();
  final _passwordFormkey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  _login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      print('printting userCredencial: ${userCredential.user}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isLandScapeMode = constraints.maxWidth > 610;
          return Container(
            alignment: Alignment.center,
            margin: isLandScapeMode
                ? const EdgeInsets.symmetric(vertical: 20)
                : const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 16,
                  ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(child: Container()),
                LogoImage(isLandScapeMode: isLandScapeMode),
                SizedBox(height: 20),
                LoginField(
                  controller: _emailController,
                  isEmailField: true,
                  formkey: _emailFormkey,
                  isPasswordVisible: _loginController.isPasswordVisible,
                ),
                SizedBox(height: 10),
                Observer(builder: (_) {
                  return LoginField(
                    controller: _passwordController,
                    isEmailField: false,
                    formkey: _passwordFormkey,
                    loginController: _loginController,
                    isPasswordVisible: _loginController.isPasswordVisible,
                  );
                }),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 50,
                      ),
                    ),
                  ),
                  onPressed: () async =>
                      _login(_emailController.text, _passwordController.text),
                  child: Text('Login'),
                ),
                Expanded(child: Container()),
                Text(
                  'Control.Weic',
                  style: AppTextStyle().loginBottomTextStyle,
                ),
                Text(
                  'Desenvolvido pelo Marcelo Cesar',
                  style: AppTextStyle().loginBottomTextStyle,
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
