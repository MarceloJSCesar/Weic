import 'package:control_weic/src/components/login/login_validation_field.dart';
import 'package:control_weic/src/config/app_textstyle.dart';
import 'package:flutter/material.dart';

class LoginField extends StatelessWidget with AppTextStyle {
  final GlobalKey<FormState>? formkey;
  final bool isEmailField;
  LoginField({
    Key? key,
    this.formkey,
    required this.isEmailField,
  }) : super(key: key);

  @override
  Form build(BuildContext context) {
    return Form(
      key: formkey,
      child: Container(
        height: 70,
        width: 350,
        child: TextFormField(
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
