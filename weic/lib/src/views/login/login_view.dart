import 'package:flutter/material.dart';
import '../../config/app_decorations.dart';
import '../../services/login/login_services.dart';
import '../../components/login/body/login_body.dart';
import '../../controllers/login/login_controller.dart';
import '../../components/login/widgets/login_bottom_text.dart';

class LoginView extends StatefulWidget {
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
                    Expanded(
                      child: Container(),
                    ),
                    LoginBottomText(),
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
