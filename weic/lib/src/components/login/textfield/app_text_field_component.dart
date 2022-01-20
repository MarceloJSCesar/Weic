import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_textstyles.dart';

class TextFormFieldComponent extends StatelessWidget {
  final String? hintText;
  final bool? isEmailField;
  final Function? showPassword;
  final Function? saveValue;
  final bool? isPasswordField;
  final Function? obscureText;
  final bool? viewPassword;
  final Function? validateField;
  final TextEditingController? controller;
  TextFormFieldComponent({
    Key? key,
    this.hintText,
    this.saveValue,
    this.controller,
    this.obscureText,
    this.viewPassword,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('$hintText'),
        SizedBox(height: 5),
        Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextFormField(
            // validator: (val) => validateField!(val),
            cursorHeight: 20,
            controller: controller,
            onSaved: (val) => saveValue!(val),
            onChanged: (val) => saveValue!(val),
            obscureText: isPasswordField! ? obscureText!() : false,
            style: AppTextStyles.dropDownTextStyle,
            keyboardType:
                isEmailField! ? TextInputType.emailAddress : TextInputType.text,
            textInputAction:
                isPasswordField! ? TextInputAction.done : TextInputAction.next,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(
                showIcon,
                color: AppColors.mainPrefixColor,
                size: 20,
              ),
              suffixIcon: isPasswordField!
                  ? IconButton(
                      iconSize: 20,
                      color: AppColors.mainPrefixColor,
                      icon: Icon(viewPassword!
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () => showPassword!(),
                    )
                  : null,
              hintText: hintText,
              hintStyle: AppTextStyles.hintTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
