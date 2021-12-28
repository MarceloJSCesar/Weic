import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:weic/src/models/student.dart';
import '../../../views/app_view.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_textstyles.dart';
import '../../../config/app_assetsnames.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../components/login/textfield/app_text_field_component.dart';
import 'package:crypton/crypton.dart';

class LoginBody extends StatelessWidget {
  final formkey;
  final loginController;
  final Function? login;
  final Function? saveLoginState;
  final Function? unsaveLoginState;
  final Function? showLoginErrorMsg;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  LoginBody({
    Key? key,
    this.login,
    this.formkey,
    this.saveLoginState,
    this.loginController,
    this.emailController,
    this.unsaveLoginState,
    this.showLoginErrorMsg,
    this.passwordController,
  }) : super(key: key);

  bool? validateFields() {
    if (emailController!.text.length > 1 &&
        passwordController!.text.length > 1) {
      if (loginController.email.isEmpty ||
          loginController.email.trim().length <= 10 ||
          loginController.password.isEmpty ||
          loginController.password.trim().length < 8) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
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
              controller: emailController,
              hintText: 'Email',
              saveValue: (val) => loginController.saveValue(true, val),
              isPasswordField: false,
              isEmailField: true,
              // validateField: (val) => loginController.validateEmail(val),
            ),
            SizedBox(height: 20),
            TextFormFieldComponent(
              controller: passwordController,
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
                  onChanged: (value) => loginController.setRemenberMe(value),
                ),
                Text(
                  'Lembrar de mim',
                  style: AppTextStyles.blackTextStyle,
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Observer(
              builder: (_) {
                return loginController.isLoading == false
                    ? ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.mainPrefixColor,
                          ),
                        ),
                        onPressed: () async => validateFields() == true
                            ? {
                                loginController.setToLoad(),
                                print(
                                    'email: ${loginController.email}, password: ${loginController.password}'),
                                await login!().then(
                                  (value) async {
                                    if (value != null) {
                                      saveLoginState!(
                                          loginController.remenberMe);
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              AppView(student: value),
                                        ),
                                      );
                                    } else {
                                      showLoginErrorMsg!(context);
                                    }
                                  },
                                ),
                                loginController.setToUnload(),
                              }
                            : () => showLoginErrorMsg!(context),
                        child: Text(
                          'Entrar',
                          style: AppTextStyles.blackTextStyle,
                        ))
                    : CircularProgressIndicator(
                        color: AppColors.mainPrefixColor,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.mainPrefixColor,
                        ),
                        strokeWidth: 3.0,
                      );
              },
            ),
          ],
        );
      },
    );
  }
}
