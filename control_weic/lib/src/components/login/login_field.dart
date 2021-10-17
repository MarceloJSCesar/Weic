import 'package:control_weic/src/components/login/login_validation_field.dart';
import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  final GlobalKey<FormState>? formkey;
  final bool isEmailField;
  const LoginField({
    Key? key,
    this.formkey,
    required this.isEmailField,
  }) : super(key: key);

  @override
  Container build(BuildContext context) {
    return Container(
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
        cursorColor: Colors.blue,
        showCursor: true,
        cursorHeight: 18,
        decoration: InputDecoration(
          labelText: isEmailField ? 'Email' : 'Password',
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
    );
  }
}
