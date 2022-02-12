import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weic/src/views/splash/splash_view.dart';
import 'views/app_view.dart';
import 'views/login/login_view.dart';
import 'services/login/login_services.dart';

class Weic extends StatelessWidget {
  const Weic({Key? key}) : super(key: key);

  @override
  MaterialApp build(BuildContext context) {
    final _loginServices = LoginServices();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
      ),
      routes: {
        LoginView.loginViewKey: (_) => LoginView(),
      },
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
                return SplashView();
              } else if (snapshot.data == null) {
                return SplashView();
              } else {
                final bool remenberMe = snapshot.data['remenberMe'];
                if (remenberMe == true) {
                  final String studentID = snapshot.data['studentID'];
                  return AppView(studentID: studentID);
                } else {
                  _loginServices.logoutUser();
                  return SplashView();
                }
              }
          }
        },
      ),
    );
  }
}
