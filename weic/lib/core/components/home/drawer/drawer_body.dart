import 'package:flutter/material.dart';
import 'package:weic/core/components/home/drawer/drawer_features.dart';
import 'package:weic/core/services/login_services.dart';
import '../../../models/user.dart';
import '../../../config/app_textstyles.dart';
import '../../../config/app_assets_names.dart';

class DrawerBody extends StatelessWidget {
  final User user;
  DrawerBody({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              user.name,
              style: AppTextStyles.hintTextStyle,
            ),
            accountEmail: Text(
              user.email,
              style: AppTextStyles.hintTextStyle,
            ),
            currentAccountPicture: CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(
                user.sexuality == 'Masculino'
                    ? AppAssetsNames.boyImageUrl
                    : AppAssetsNames.womanImageUrl,
              ),
            ),
          ),
          Divider(),
          Column(
            children: <Widget>[
              DrawerFeatures(
                title: 'About',
                onTap: () => Navigator.of(context).pushNamed(
                  '/home/drawer_about',
                ),
              ),
              DrawerFeatures(
                title: 'Logout',
                onTap: () async {
                  await LoginServices().logout();
                  Navigator.of(context).pushReplacementNamed('/login');
                },
              ),
            ],
          ),
          Expanded(
            child: Container(),
          ),
          ClipOval(
            child: Image(
              width: 200,
              image: AssetImage(AppAssetsNames.logoImageUrl),
            ),
          ),
          Text(
            'Marcelo Cesar',
            style: AppTextStyles.blackTextStyle,
          ),
        ],
      ),
    );
  }
}

/* 
Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage(
                      user.sexuality == 'Masculino'
                          ? AppAssetsNames.boyImageUrl
                          : AppAssetsNames.womanImageUrl,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        user.name,
                        style: AppTextStyles.hintTextStyle,
                      ),
                      Text(
                        user.email,
                        style: AppTextStyles.hintTextStyle,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        )
*/
