import 'package:flutter/material.dart';
import '../../../config/app_textstyles.dart';
import '../../../config/app_assetsnames.dart';
import '../../../config/app_decorations.dart';

class AppBarComponent extends PreferredSize {
  final BuildContext? context;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  AppBarComponent({this.scaffoldKey, this.context})
      : super(
          preferredSize: Size.fromHeight(200),
          child: Container(
            decoration: AppDecorations.homeviewDecoration,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        child: Icon(
                          Icons.menu,
                          size: 25,
                          color: Colors.black,
                        ),
                        onTap: () => scaffoldKey!.currentState!.openDrawer(),
                      ),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(AppAssetsNames.boyImageUrl),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text.rich(
                        TextSpan(
                          text: 'Bem Vindo, ',
                          style: AppTextStyles.title,
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Marcelo Cesar',
                              style: AppTextStyles.titleBold,
                            ),
                          ],
                        ),
                      ),
                      Text('ESAD', style: AppTextStyles.title),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
}
