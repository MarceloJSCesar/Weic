import 'package:flutter/material.dart';
import '../../../config/app_decorations.dart';

class DrawerFeatures extends StatelessWidget {
  final String title;
  final Function onTap;
  DrawerFeatures({required this.title, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: () => onTap,
      trailing: Icon(
        Icons.arrow_right,
        color: Colors.black,
      ),
      shape: AppDecorations.drawerFeaturesDecoration,
    );
  }
}
