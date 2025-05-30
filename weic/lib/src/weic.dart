import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';
import 'package:weic/src/views/splash/splash_view.dart';
import 'views/app_view.dart';
import 'views/login/login_view.dart';
import 'services/login/login_services.dart';

class Weic extends StatefulWidget {
  const Weic({Key? key}) : super(key: key);

  @override
  State<Weic> createState() => _WeicState();
}

class _WeicState extends State<Weic> {
  StreamSubscription? _streamSubscription;
  bool? isConnectedToInternet;

  @override
  void initState() {
    super.initState();
    SimpleConnectionChecker _simpleConnectionChecker = SimpleConnectionChecker()
      ..setLookUpAddress('pub.dev');
    _streamSubscription =
        _simpleConnectionChecker.onConnectionChange.listen((connection) {
      setState(() {
        isConnectedToInternet = connection;
      });
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  MaterialApp build(BuildContext context) {
    final _loginServices = LoginServices();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      theme: ThemeData(
        brightness: Brightness.dark,
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
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
                  final String studentID = snapshot.data['studentID'] != null
                      ? snapshot.data['studentID']
                      : '';
                  return studentID.length == 0
                      ? LoginView()
                      : AppView(
                          studentID: studentID,
                        );
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
