import 'package:flutter/material.dart';
import 'package:weic/src/components/login/body/login_body.dart';
import 'package:weic/src/config/app_textstyles.dart';
import '../../controllers/login/login_controller.dart';

class LoginView extends StatefulWidget {
  static const String loginViewKey = 'loginViewKey';
  LoginView({Key? key}) : super(key: key);
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isPasswordVisible = false;
  final _loginController = LoginController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loginController.listenUserLogChanges();
  }

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: <Widget>[
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: LoginBody(
                  emailController: _emailController,
                  isPasswordVisible: _isPasswordVisible,
                  passwordController: _passwordController,
                  onPasswordVisibilityToggle: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                    print(_isPasswordVisible);
                  },
                ),
              ),
            ),
            Expanded(child: Container()),
            Container(
              alignment: Alignment.center,
              child: Text(
                'WEIC v1.0',
                style: AppTextStyles.chatTabTitleTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
