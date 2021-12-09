import 'package:flutter/material.dart';
import 'views/login/login_view.dart';

class Weic extends StatelessWidget {
  const Weic({Key? key}) : super(key: key);

  @override
  MaterialApp build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginView(),
    );
  }
}
