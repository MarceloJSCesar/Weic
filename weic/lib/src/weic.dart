import 'package:flutter/material.dart';
import 'models/student.dart';
import 'views/app_view.dart';
import 'views/login/login_view.dart';
import 'services/login/login_services.dart';
import 'controllers/login/login_controller.dart';

class Weic extends StatelessWidget {
  const Weic({Key? key}) : super(key: key);

  @override
  MaterialApp build(BuildContext context) {
    final _loginController = LoginController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: LoginServices().getLoginState(),
        builder: (context, snapshot) {
          if (_loginController.auth.currentUser == null) {
            return LoginView();
          } else {
            if (snapshot.data == true &&
                _loginController.auth.currentUser != null) {
              return AppView(
                student: Student(
                  email: _loginController.auth.currentUser!.email,
                  password: _loginController.password,
                ),
              );
            }
          }
          return LoginView();
        },
      ),
    );
  }
}
