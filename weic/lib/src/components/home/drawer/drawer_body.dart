import 'package:flutter/material.dart';
import 'drawer_feautures.dart';
import '../../../config/app_textstyles.dart';
import '../../../config/app_assetsnames.dart';

class DrawerBody extends StatelessWidget {
  DrawerBody({
    Key? key,
  }) : super(key: key);

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
              'null',
              style: AppTextStyles.hintTextStyle,
            ),
            accountEmail: Text(
              'null',
              style: AppTextStyles.hintTextStyle,
            ),
            currentAccountPicture: CircleAvatar(
              radius: 35,
              backgroundImage: AssetImage(AppAssetsNames.boyImageUrl),
            ),
          ),
          Divider(),
          Column(
            children: <Widget>[
              DrawerFeatures(
                title: 'Sobre o aplicativo',
                onTap: () => Navigator.of(context).pushNamed(
                  '/home/drawer_about',
                ),
              ),
              DrawerFeatures(
                title: 'Sair',
                onTap: () async {
                  //await LoginServices().logout();
                  //Navigator.of(context).pushReplacementNamed('/login');
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
