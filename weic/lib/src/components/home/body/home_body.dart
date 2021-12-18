import 'package:flutter/material.dart';
import 'package:weic/src/components/home/widgets/app_bar_component.dart';
import '../../../config/app_decorations.dart';

class HomeBody extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const HomeBody({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              decoration: AppDecorations.homeviewDecoration,
              child: AppBarComponent(
                context: context,
                scaffoldKey: scaffoldKey,
              ),
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
