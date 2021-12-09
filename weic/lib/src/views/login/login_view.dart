import 'package:flutter/material.dart';
import '../../config/app_colors.dart';
import '../../config/app_textstyles.dart';
import '../../config/app_decorations.dart';
import '../../config/app_assetsnames.dart';
import '../../controllers/login/login_controller.dart';
import '../../components/app_text_field_component.dart';

class LoginView extends StatefulWidget {
  LoginView({Key? key}) : super(key: key);
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _loginController = LoginController();
  final _formKey = GlobalKey<FormState>();
  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppDecorations.mainDecoration,
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  ClipOval(
                    child: Image(
                      width: 300,
                      image: AssetImage(AppAssetsNames.logoImageUrl),
                    ),
                  ),
                  Card(
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.black,
                    shadowColor: Colors.black,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 40,
                      ),
                      child: Column(
                        children: <Widget>[
                          TextFormFieldComponent(
                            hintText: 'Email',
                            //saveValue: (val) => email = val,
                            isPasswordField: false,
                            isEmailField: true,
                            validateField: (val) =>
                                _loginController.validateEmail(val),
                          ),
                          Divider(),
                          TextFormFieldComponent(
                            hintText: 'Password',
                            //saveValue: (val) => password = val,
                            isPasswordField: true,
                            isEmailField: false,
                            validateField: (val) =>
                                _loginController.validatePassword(val),
                            showPassword: () => setState(() {
                              _loginController.viewPasswordValue();
                            }),
                            obscureText: () {
                              if (_loginController.viewPassword == true) {
                                return true;
                              } else {
                                return false;
                              }
                            },
                            viewPassword: _loginController.viewPassword,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.mainPrefixColor,
                              ),
                            ),
                            onPressed: () {},
                            child: Text('Entrar'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            child: Text(
                              'Nao tenho uma conta, Registrar',
                              style: AppTextStyles.hintTextStyle,
                            ),
                            onTap: () => Navigator.of(context)
                                .pushReplacementNamed('/register'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
