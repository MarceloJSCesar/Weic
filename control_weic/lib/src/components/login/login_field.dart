import 'package:flutter/material.dart';
import '../../config/app_textstyle.dart';
import '../../controllers/login/login_controller.dart';
import '../../components/login/login_validation_field.dart';

class LoginField extends StatelessWidget with AppTextStyle {
  final bool isEmailField;
  final bool isPasswordVisible;
  final GlobalKey<FormState>? formkey;
  final LoginController? loginController;
  LoginField({
    Key? key,
    this.formkey,
    this.loginController,
    required this.isEmailField,
    required this.isPasswordVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Container(
        height: 70,
        width: 350,
        child: TextFormField(
          textInputAction:
              isEmailField ? TextInputAction.next : TextInputAction.done,
          obscureText: isEmailField
              ? false
              : isPasswordVisible
                  ? false
                  : true,
          validator: (val) => isEmailField
              ? LoginValidationField().validationEmail(val)
              : LoginValidationField().validationPassword(val),
          onChanged: (val) {
            if (formkey!.currentState!.validate()) {
              print('validated');
            } else {
              print('not validated yet');
            }
          },
          cursorColor: Colors.grey.shade600,
          showCursor: true,
          cursorHeight: 18,
          decoration: InputDecoration(
            suffixIcon: isEmailField
                ? null
                : IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () => isPasswordVisible
                        ? loginController!.setPasswordObscure()
                        : loginController!.setPasswordVisible()),
            labelText: isEmailField ? 'Email' : 'Password',
            labelStyle: loginLabelTextStyle,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.grey.shade300,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14,
            ),
          ),
        ),
      ),
    );
  }
}
