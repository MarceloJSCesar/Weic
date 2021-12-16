import 'package:flutter/material.dart';
import 'package:weic/src/models/student.dart';
import 'package:weic/src/views/app_view.dart';
import 'controllers/login/login_controller.dart';
import 'views/login/login_view.dart';

class Weic extends StatelessWidget {
  const Weic({Key? key}) : super(key: key);

  @override
  MaterialApp build(BuildContext context) {
    final _loginController = LoginController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _loginController.auth.currentUser == null
          ? LoginView()
          : AppView(
              student: Student(
                email: _loginController.email,
                password: _loginController.password,
              ),
            ),
    );
  }
}
