import 'package:flutter/material.dart';

class AppDecorations {
  static final mainDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Colors.grey,
        Colors.red,
      ],
    ),
  );
  static final homeviewDecoration = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        Colors.grey,
        Colors.red,
      ],
    ),
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(30),
    ),
  );
  static final drawerFeaturesDecoration = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  );
}
