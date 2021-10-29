import 'package:flutter/material.dart';
import 'views/login/login_view.dart';

class ControlWeic extends StatelessWidget {
  const ControlWeic({Key? key}) : super(key: key);

  @override
  MaterialApp build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginView(),
    );
  }
}
