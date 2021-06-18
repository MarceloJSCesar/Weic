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
}
