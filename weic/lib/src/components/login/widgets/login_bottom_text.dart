import 'package:flutter/material.dart';
import '../../../config/app_textstyles.dart';

class LoginBottomText extends StatelessWidget {
  const LoginBottomText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        child: Text(
          'Developed by Marcelo Cesar',
          style: AppTextStyles.blackTextStyle,
        ),
      ),
    );
  }
}
