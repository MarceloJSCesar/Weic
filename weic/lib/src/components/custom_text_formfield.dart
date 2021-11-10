import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/app_textstyles.dart';

class TextFormFieldComponent extends StatelessWidget {
  final String? hintText;
  final bool? isEmailField;
  final Function? showPassword;
  final Function? saveValue;
  final bool? isPasswordField;
  final Function? obscureText;
  final bool? viewPassword;
  final Function? validateField;
  TextFormFieldComponent({
    Key? key,
    this.hintText,
    this.viewPassword,
    this.obscureText,
    this.saveValue,
    this.showPassword,
    this.isEmailField,
    this.validateField,
    this.isPasswordField,
  }) : super(key: key);

  IconData get showIcon {
    if (isEmailField == true) {
      return Icons.email;
    } else if (isPasswordField == true) {
      return Icons.security;
    } else {
      return Icons.person;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        validator: (val) => validateField!(val),
        onSaved: (val) => saveValue!(val),
        onChanged: (val) => saveValue!(val),
        obscureText: isPasswordField! ? obscureText!() : false,
        style: AppTextStyles.dropDownTextStyle,
        keyboardType:
            isEmailField! ? TextInputType.emailAddress : TextInputType.text,
        textInputAction:
            isPasswordField! ? TextInputAction.done : TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(showIcon, color: AppColors.mainPrefixColor),
          suffixIcon: isPasswordField!
              ? IconButton(
                  icon: Icon(
                      viewPassword! ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => showPassword!(),
                )
              : null,
          hintText: hintText,
          hintStyle: AppTextStyles.hintTextStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
