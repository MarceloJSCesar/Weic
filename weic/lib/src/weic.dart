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
        builder: (context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return LoginView();
            case ConnectionState.waiting:
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                    strokeWidth: 3.0,
                  ),
                ),
              );
            default:
              if (snapshot.hasError) {
                return LoginView();
              } else if (snapshot.data == null) {
                return LoginView();
              } else {
                final bool remenberMe = snapshot.data['remenberMe'];
                if (remenberMe == true) {
                  final String studentID = snapshot.data['studentID'];
                  return AppView(studentID: studentID);
                } else {
                  return LoginView();
                }
              }
          }
        },
      ),
    );
  }
}
