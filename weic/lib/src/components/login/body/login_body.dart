import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_textstyles.dart';
import '../../../config/app_assetsnames.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../components/login/textfield/app_text_field_component.dart';

class LoginBody extends StatelessWidget {
  final loginController;
  final formkey;
  LoginBody({
    Key? key,
    this.formkey,
    this.loginController,
  }) : super(key: key);

  bool? validateFields() {
    if (loginController.email.isEmpty ||
        loginController.email.trim().length <= 10 ||
        loginController.password.isEmpty ||
        loginController.password.trim().length < 8) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image(
              width: 200,
              fit: BoxFit.fill,
              image: AssetImage(AppAssetsNames.logoImageUrl),
            ),
            SizedBox(height: 20),
            TextFormFieldComponent(
              hintText: 'Email',
              saveValue: (val) => loginController.saveValue(true, val),
              isPasswordField: false,
              isEmailField: true,
              // validateField: (val) => loginController.validateEmail(val),
            ),
            SizedBox(height: 20),
            TextFormFieldComponent(
              hintText: 'Password',
              isPasswordField: true,
              isEmailField: false,
              saveValue: (val) => loginController.saveValue(false, val),
              //  validateField: (val) => loginController.validatePassword(val),
              showPassword: () => loginController.viewPasswordValue(),
              obscureText: () {
                if (loginController.viewPassword == true) {
                  return true;
                } else {
                  return false;
                }
              },
              viewPassword: loginController.viewPassword,
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  AppColors.mainPrefixColor,
                ),
              ),
              onPressed: () => validateFields() == true
                  ? {
                      print(
                          'email: ${loginController.email}, password: ${loginController.password}'),
                    }
                  : {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.red,
                          content: Text(
                            'Usuário não encontrado',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    },
              child: Text(
                'Entrar',
                style: AppTextStyles.blackTextStyle,
              ),
            ),
          ],
        );
      },
    );
  }
}
