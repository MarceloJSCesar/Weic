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
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (_loginController.auth.currentUser == null) {
            return LoginView();
          } else {
            print('snapshot.data: ${snapshot.data}');
            bool remenberMe = snapshot.data?[0] as bool;
            String studentID = snapshot.data?[1] as String;
            if (remenberMe == true &&
                _loginController.auth.currentUser != null) {
              return AppView(
                studentID: studentID,
              );
            }
          }
          return LoginView();
        },
      ),
    );
  }
}
