import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:weic/core/config/app_textstyles.dart';

// ignore: must_be_immutable
class TextFormFieldComponent extends StatefulWidget {
  final String hintText;
  final Function saveValue;
  var isPasswordField;
  TextFormFieldComponent({
    Key key,
    this.hintText,
    this.saveValue,
    this.isPasswordField,
  }) : super(key: key);

  @override
  _TextFormFieldComponentState createState() => _TextFormFieldComponentState();
}

class _TextFormFieldComponentState extends State<TextFormFieldComponent> {
  bool viewPassword = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        onSaved: (val) => widget.saveValue(val),
        onChanged: (val) => widget.saveValue(val),
        obscureText: viewPassword,
        style: AppTextStyles.dropDownTextStyle,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  icon: Icon(
                    viewPassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () => setState(() {
                    viewPassword = !viewPassword;
                    print(viewPassword);
                  }),
                )
              : null,
          hintText: widget.hintText,
          hintStyle: AppTextStyles.hintTextStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
