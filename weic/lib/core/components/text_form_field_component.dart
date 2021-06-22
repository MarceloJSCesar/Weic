import 'package:flutter/material.dart';
import 'package:weic/core/config/app_textstyles.dart';

// ignore: must_be_immutable
class TextFormFieldComponent extends StatelessWidget {
  String value;
  final String hintText;
  final bool isPassword;
  TextFormFieldComponent({
    Key key,
    this.value,
    this.hintText,
    this.isPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        onSaved: (val) => value = val,
        onChanged: (val) => value = val,
        style: AppTextStyles.dropDownTextStyle,
        textInputAction:
            isPassword ? TextInputAction.next : TextInputAction.done,
        decoration: InputDecoration(
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
