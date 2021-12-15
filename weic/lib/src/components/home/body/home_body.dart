import 'package:flutter/material.dart';
import '../../../config/app_text.dart';
import '../../../config/app_textstyles.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Divider(),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                AppText.appInfText,
                style: AppTextStyles.dropDownTextStyle,
              ),
            ),
          ),
          Divider(),
          //CardHome(),
          Expanded(
            child: Container(),
          ),
          Text('WEIC version 1'),
          Text(
            'Marcelo Cesar',
            style: AppTextStyles.blackTextStyle,
          )
        ],
      ),
    );
  }
}
