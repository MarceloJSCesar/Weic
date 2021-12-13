import 'package:flutter/material.dart';
import 'package:weic/src/services/login/login_services.dart';
import '../../config/app_textstyles.dart';
import '../../config/app_decorations.dart';
import '../../components/login/body/login_body.dart';
import '../../controllers/login/login_controller.dart';

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
    _loginServices.listenUserLogChanges();
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
