import "package:flutter/material.dart";
import '../../../config/app_textstyles.dart';

class SnackbarTextButton extends StatelessWidget with AppTextStyles {
  final String? text;
  final onPressed;
  SnackbarTextButton({
    Key? key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Text(
          text ?? "",
          textAlign: TextAlign.left,
          style: snackbarTextButtonTextStyle,
        ),
      ),
    );
  }
}
