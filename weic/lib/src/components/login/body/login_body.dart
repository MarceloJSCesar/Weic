import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:weic/src/controllers/login/login_controller.dart';

import '../../../config/app_assetsnames.dart';
import '../widgets/text_field_component.dart';

class LoginBody extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final LoginController loginController;
  const LoginBody({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.loginController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
        builder: (_) => Column(
              children: <Widget>[
                Image(
                  width: 290,
                  fit: BoxFit.fill,
                  image: AssetImage(AppAssetsNames.logoImageUrl),
                ),
                SizedBox(height: 16),
                TextFieldComponent(
                  label: 'Email',
                  controller: emailController,
                  isPasswordVisible: loginController.viewPassword,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFieldComponent(
                  label: 'Password',
                  isEmailField: false,
                  controller: passwordController,
                  isPasswordVisible: loginController.viewPassword,
                  viewPassword: () => loginController.viewPassword,
                ),
              ],
            ));
  }
}
