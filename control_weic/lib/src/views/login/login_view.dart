import 'package:control_weic/src/components/login/login_field.dart';
import 'package:control_weic/src/components/login/logo_image.dart';
import 'package:control_weic/src/config/app_asset_name.dart';
import 'package:control_weic/src/controllers/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController _loginController = LoginController();
  final _emailFormkey = GlobalKey<FormState>();
  final _passwordFormkey = GlobalKey<FormState>();
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
                : const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(child: Container()),
                LogoImage(isLandScapeMode: isLandScapeMode),
                SizedBox(height: 20),
                LoginField(
                  isEmailField: true,
                  formkey: _emailFormkey,
                  isPasswordVisible: _loginController.isPasswordVisible,
                ),
                SizedBox(height: 10),
                Observer(builder: (_) {
                  return LoginField(
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
                        vertical: 15,
                        horizontal: 50,
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Text('Login'),
                ),
                Expanded(child: Container()),
                Text('Control.Weic'),
                Text('Desenvolvido pelo Marcelo;}) Cesar'),
              ],
            ),
          );
        },
      ),
    );
  }
}
