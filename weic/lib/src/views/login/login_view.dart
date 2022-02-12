import 'package:flutter/material.dart';
import 'package:weic/src/components/login/body/login_body.dart';
import 'package:weic/src/config/app_textstyles.dart';
import '../../services/login/login_services.dart';
import '../../controllers/login/login_controller.dart';

class LoginView extends StatefulWidget {
  static const String loginViewKey = 'loginViewKey';
  LoginView({Key? key}) : super(key: key);
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _loginController = LoginController();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginServices = LoginServices();

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
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2.5),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: SingleChildScrollView(
                child: LoginBody(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  loginController: _loginController,
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
/*
LoginBody(
                      formkey: _formKey,
                      login: () => _loginServices.login(
                        _emailController.text,
                        _passwordController.text,
                      ),
                      emailController: _emailController,
                      loginController: _loginController,
                      passwordController: _passwordController,
                      showLoginErrorMsg: (context) =>
                          _loginServices.showLoginMsgError(context: context),
                      saveLoginState: (remenberMe) =>
                          _loginServices.saveLoginState(remenberMe),
                      unsaveLoginState: () => _loginServices.unsaveLoginState(),
                    ),
*/
