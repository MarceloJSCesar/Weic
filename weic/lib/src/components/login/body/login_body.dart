import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_textstyles.dart';
import '../../../config/app_assetsnames.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../components/login/textfield/app_text_field_component.dart';

class LoginBody extends StatelessWidget {
  final loginController;
  const LoginBody({
    Key? key,
    this.loginController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        return Column(
          children: <Widget>[
            ClipOval(
              child: Image(
                width: 250,
                fit: BoxFit.fill,
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
                          loginController.validateEmail(val),
                    ),
                    Divider(),
                    TextFormFieldComponent(
                      hintText: 'Password',
                      //saveValue: (val) => password = val,
                      isPasswordField: true,
                      isEmailField: false,
                      validateField: (val) =>
                          loginController.validatePassword(val),
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
        );
      },
    );
  }
}
