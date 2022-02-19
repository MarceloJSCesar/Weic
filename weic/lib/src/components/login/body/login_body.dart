import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weic/src/controllers/login/login_controller.dart';

import '../../../config/app_assetsnames.dart';
import '../../../config/app_colors.dart';
import '../../../services/home/home_services.dart';
import '../../../views/app_view.dart';
import '../../../views/dados_essencial/dados_essencial_view.dart';
import '../widgets/text_field_component.dart';

class LoginBody extends StatelessWidget {
  final Function? login;
  final bool isPasswordVisible;
  final Function? saveLoginState;
  final Function? unsaveLoginState;
  final Function? showLoginErrorMsg;
  final onPasswordVisibilityToggle;
  final LoginController loginController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  const LoginBody({
    Key? key,
    required this.login,
    required this.emailController,
    required this.saveLoginState,
    required this.loginController,
    required this.unsaveLoginState,
    required this.showLoginErrorMsg,
    required this.isPasswordVisible,
    required this.passwordController,
    required this.onPasswordVisibilityToggle,
  }) : super(key: key);

  bool? validateFields() {
    if (emailController.text.isEmpty ||
        emailController.text.trim().length <= 10 ||
        passwordController.text.isEmpty ||
        passwordController.text.trim().length < 8) {
      return false;
    } else {
      return true;
    }
  }

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
        SizedBox(height: 16),
        Observer(
          builder: (_) {
            return loginController.isLoading == false
                ? GestureDetector(
                    onTap: () async => validateFields() == true
                        ? {
                            loginController.setToLoad(),
                            print(
                                'email: ${loginController.email}, password: ${loginController.password}'),
                            await login!().then(
                              (value) async {
                                if (value != null) {
                                  final _prefs =
                                      await SharedPreferences.getInstance();
                                  await _prefs.setString(
                                    'STUDENT_ID',
                                    value.id,
                                  );
                                  saveLoginState!(loginController.remenberMe);
                                  await HomeServices()
                                      .getStudentEssentialData(
                                    studentID: value.id,
                                  )
                                      .then((data) {
                                    if (data == null) {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (_) => DadosEssenciaisView(
                                            student: value,
                                          ),
                                        ),
                                      );
                                    } else {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              AppView(studentID: value.id),
                                        ),
                                      );
                                    }
                                  });
                                } else {
                                  showLoginErrorMsg!(context);
                                }
                              },
                            ),
                            loginController.setToUnload(),
                          }
                        : () => showLoginErrorMsg!(context),
                    child: Container(
                      alignment: Alignment.center,
                      child: Container(
                        height: 40,
                        width: 100,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xFF03989e),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Entrar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  )
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
  }
}
