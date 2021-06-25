import 'package:flutter/material.dart';
import 'package:weic/core/config/app_decorations.dart';
import 'package:weic/core/config/app_textstyles.dart';

class CardHomeOptions extends StatelessWidget {
  final Function onTap;
  final String title;
  const CardHomeOptions({Key key, this.onTap, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap,
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Colors.grey,
              Colors.red,
            ],
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        height: 150,
        width: 150,
        child: Center(
          child: Text(
            title,
            style: AppTextStyles.dropDownTextStyle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
