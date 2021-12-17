import 'package:flutter/material.dart';
import 'package:weic/src/models/student.dart';
import 'package:weic/src/views/app_view.dart';
import 'controllers/login/login_controller.dart';
import 'services/login/login_services.dart';
import 'views/login/login_view.dart';

class Weic extends StatelessWidget {
  Weic({Key? key}) : super(key: key);

  @override
  MaterialApp build(BuildContext context) {
    final _loginController = LoginController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: LoginServices().getLoginState(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return LoginView();
            case ConnectionState.active:
              return AppView(
                student: Student(
                  email: _loginController.auth.currentUser!.email,
                  password: _loginController.password,
                ),
              );
            default:
              if (_loginController.auth.currentUser == null) {
                return LoginView();
              } else {
                if (snapshot.data == true) {
                  return AppView(
                    student: Student(
                      email: _loginController.auth.currentUser!.email,
                      password: _loginController.password,
                    ),
                  );
                }
              }
              return LoginView();
          }
        },
      ),
    );
  }
}
