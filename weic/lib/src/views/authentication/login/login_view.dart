import 'package:flutter/material.dart';
import 'package:weic/src/config/app_colors.dart';
import 'package:weic/src/config/app_decorations.dart';
import 'package:weic/src/config/app_img_path.dart';
import 'package:weic/src/config/app_textstyles.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: AppDecorations.mainDecoration,
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  ClipOval(
                    child: Image(
                      width: 300,
                      image: AssetImage(AppImgPath.logoImageUrl),
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
                            saveValue: (val) => email = val,
                            isPasswordField: false,
                            isEmailField: true,
                            validateField: (val) => _auth.validateEmail(val),
                          ),
                          Divider(),
                          TextFormFieldComponent(
                            hintText: 'Password',
                            saveValue: (val) => password = val,
                            isPasswordField: true,
                            isEmailField: false,
                            validateField: (val) => _auth.validatePassword(val),
                            showPassword: () => setState(() {
                              _auth.viewPasswordValue();
                            }),
                            obscureText: () {
                              if (_auth.viewPassword == true) {
                                return true;
                              } else {
                                return false;
                              }
                            },
                            viewPassword: _auth.viewPassword,
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
