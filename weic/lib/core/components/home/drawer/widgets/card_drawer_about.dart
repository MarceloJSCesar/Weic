import 'package:flutter/material.dart';
import 'package:weic/core/config/app_assets_names.dart';
import 'package:weic/core/config/app_decorations.dart';
import 'package:weic/core/config/app_textstyles.dart';

class CardDrawerAbout extends StatelessWidget {
  final String name;
  final String imageUrl;
  final String description;
  const CardDrawerAbout({
    Key key,
    @required this.name,
    this.description,
    @required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20.0,
      shape: AppDecorations.drawerFeaturesDecoration,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(imageUrl),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  name,
                  style: AppTextStyles.blackTextStyle,
                ),
                description == null
                    ? Container()
                    : Text(
                        description,
                        style: AppTextStyles.blackTextStyle,
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
