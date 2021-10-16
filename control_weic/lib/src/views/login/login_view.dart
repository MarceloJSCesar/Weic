import 'package:control_weic/src/config/app_asset_name.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Scaffold build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constraints) {
        bool isLandScapeMode = constraints.maxWidth > 610;
        return Container(
          alignment: Alignment.center,
          margin: isLandScapeMode
              ? const EdgeInsets.symmetric(horizontal: 100, vertical: 20)
              : const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                width: isLandScapeMode ? 200 : 150,
                fit: BoxFit.fill,
                image: AssetImage(AppAssetName().weicLogoImgUrl),
              ),
            ],
          ),
        );
      }),
    );
  }
}
