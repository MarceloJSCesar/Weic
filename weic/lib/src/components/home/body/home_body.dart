import 'package:flutter/material.dart';
import 'package:weic/src/config/app_decorations.dart';
import '../../../config/app_text.dart';
import '../../../config/app_textstyles.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              decoration: AppDecorations.homeviewDecoration,
            ),
          ),
          Expanded(
            flex: 8,
            child: Center(child: Text('2nd section')),
          ),
        ],
      ),
    );
  }
}
