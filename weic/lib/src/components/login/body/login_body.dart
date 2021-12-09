import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_textstyles.dart';
import '../../../config/app_assetsnames.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../components/login/textfield/app_text_field_component.dart';

class LoginBody extends StatelessWidget {
  final loginController;
  LoginBody({
    Key? key,
    this.loginController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Card(
          clipBehavior: Clip.antiAlias,
          elevation: 10.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                  saveValue: (val) => loginController.saveValue(true, val),
                  isPasswordField: false,
                  isEmailField: true,
                  validateField: (val) => loginController.validateEmail(val),
                ),
                Divider(),
                TextFormFieldComponent(
                  hintText: 'Password',
                  isPasswordField: true,
                  isEmailField: false,
                  saveValue: (val) => loginController.saveValue(false, val),
                  validateField: (val) => loginController.validatePassword(val),
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
                    backgroundColor: MaterialStateProperty.all<Color>(
                      AppColors.mainPrefixColor,
                    ),
                  ),
                  onPressed: () {
                    print(
                        'email: ${loginController.email}, password: ${loginController.password}');
                  },
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
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed('/register'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
