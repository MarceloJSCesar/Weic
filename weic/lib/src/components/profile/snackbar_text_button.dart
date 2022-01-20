import "package:flutter/material.dart";
import 'package:weic/src/config/app_textstyles.dart';

class SnackbarTextButton extends StatelessWidget with AppTextStyles {
  final String? text;
  final Function? onPressed;
  SnackbarTextButton({
    Key? key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed,
      child: Text(
        text ?? "",
        style: snackbarTextButtonTextStyle,
      ),
    );
  }
}
