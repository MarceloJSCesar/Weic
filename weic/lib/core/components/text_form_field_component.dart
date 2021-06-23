import 'package:flutter/material.dart';
import 'package:weic/core/config/app_textstyles.dart';

// ignore: must_be_immutable
class TextFormFieldComponent extends StatelessWidget {
  final String hintText;
  final Function saveValue;
  final bool isPasswordField;
  TextFormFieldComponent({
    Key key,
    this.hintText,
    this.saveValue,
    this.isPasswordField,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        onSaved: (val) => saveValue(val),
        onChanged: (val) => saveValue(val),
        obscureText: isPasswordField
            ? true
                ? true
                : false
            : false,
        style: AppTextStyles.dropDownTextStyle,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          suffixIcon: isPasswordField
              ? IconButton(
                  icon: Icon(
                    true ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {})
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
