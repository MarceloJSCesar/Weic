import 'package:control_weic/src/config/app_asset_name.dart';
import 'package:flutter/material.dart';

class LogoImage extends StatelessWidget with AppAssetName {
  final bool isLandScapeMode;
  LogoImage({
    Key? key,
    required this.isLandScapeMode,
  }) : super(key: key);

  @override
  Image build(BuildContext context) {
    return Image(
      width: isLandScapeMode ? 200 : 150,
      fit: BoxFit.fill,
      image: AssetImage(weicLogoImgUrl),
    );
  }
}
