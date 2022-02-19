import 'package:flutter/material.dart';

import '../../../config/app_assetsnames.dart';
import '../widgets/text_field_component.dart';

class LoginBody extends StatelessWidget {
  final bool isPasswordVisible;
  final onPasswordVisibilityToggle;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginBody({
    Key? key,
    required this.emailController,
    required this.isPasswordVisible,
    required this.passwordController,
    required this.onPasswordVisibilityToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
        ),
        SizedBox(
          height: 10,
        ),
        TextFieldComponent(
          label: 'Password',
          isEmailField: false,
          controller: passwordController,
          isPasswordVisible: isPasswordVisible,
          viewPassword: () => onPasswordVisibilityToggle(),
        ),
      ],
    );
  }
}
