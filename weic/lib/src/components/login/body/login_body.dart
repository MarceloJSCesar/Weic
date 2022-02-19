import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:weic/src/controllers/login/login_controller.dart';

import '../../../config/app_assetsnames.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_textstyles.dart';
import '../widgets/text_field_component.dart';

class LoginBody extends StatelessWidget {
  final bool isPasswordVisible;
  final onPasswordVisibilityToggle;
  final LoginController loginController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginBody({
    Key? key,
    required this.emailController,
    required this.loginController,
    required this.isPasswordVisible,
    required this.passwordController,
    required this.onPasswordVisibilityToggle,
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
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                  side: BorderSide(color: Colors.black),
                ),
                activeColor: AppColors.mainPrefixColor,
                value: loginController.remenberMe,
                onChanged: (value) =>
                    loginController.setRemenberMe(value as bool),
              ),
              Text(
                'Lembrar de mim',
                style: AppTextStyles.hintTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
