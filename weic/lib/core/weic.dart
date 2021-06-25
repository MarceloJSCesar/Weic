import 'package:flutter/material.dart';
import 'package:weic/core/components/home/calculus/trimestre/calculus_trimestre.dart';
import './views/home/home_view.dart';
import './views/login/login_view.dart';
import './services/login_services.dart';
import './views/register/register_view.dart';
import './components/home/drawer/drawer_about.dart';

class Weic extends StatelessWidget {
  Weic({Key key}) : super(key: key);

  final LoginServices _loginServices = LoginServices();

  Future<int> getId() async {
    int id = await LoginServices().getUserId();
    return id;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.white,
      ),
      routes: {
        '/login': (_) => LoginView(),
        '/register': (_) => RegisterView(),
        '/home/drawer_about': (_) => DrawerAbout(),
        '/home/calculus/trimestre': (_) => CalculusTrimestre()
      },
      home: FutureBuilder(
        future: _loginServices.getUserEmail(),
        builder: (context, snapshotEmail) {
          switch (snapshotEmail.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  strokeWidth: 3.0,
                ),
              );
            default:
              if (snapshotEmail.hasData) {
                return FutureBuilder(
                  future: _loginServices.getUserId(),
                  builder: (context, snapshotID) {
                    switch (snapshotID.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black),
                            strokeWidth: 3.0,
                          ),
                        );
                      case ConnectionState.active:
                      case ConnectionState.done:
                        return HomeView(userId: snapshotID.data);
                      default:
                        if (snapshotID.hasData) {
                          return HomeView(userId: snapshotID.data);
                        } else {
                          return LoginView();
                        }
                    }
                  },
                );
              } else {
                return LoginView();
              }
          }
        },
      ),
    );
  }
}
