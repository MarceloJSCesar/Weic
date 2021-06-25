import 'package:flutter/material.dart';
import 'package:weic/core/config/app_assets_names.dart';
import 'package:weic/core/config/app_decorations.dart';
import 'package:weic/core/config/app_textstyles.dart';
import 'package:weic/core/models/user.dart';

class AppBarComponent extends PreferredSize {
  final User user;
  final BuildContext context;
  final GlobalKey<ScaffoldState> scaffoldKey;
  AppBarComponent({this.user, this.scaffoldKey, this.context})
      : super(
          preferredSize: Size.fromHeight(200),
          child: Container(
            decoration: AppDecorations.homeviewDecoration,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                          icon: Icon(
                            Icons.menu,
                            size: 25,
                          ),
                          color: Colors.black,
                          onPressed: () =>
                              scaffoldKey.currentState.openDrawer()),
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(
                          user.sexuality == 'Masculino'
                              ? AppAssetsNames.boyImageUrl
                              : AppAssetsNames.womanImageUrl,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
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
                                text: user.name,
                                style: AppTextStyles.titleBold),
                          ],
                        ),
                      ),
                      Text(user.school, style: AppTextStyles.title),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
}
