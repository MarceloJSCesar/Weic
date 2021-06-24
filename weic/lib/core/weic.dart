import 'package:flutter/material.dart';
import 'package:weic/core/components/home/drawer/drawer_body.dart';
import 'package:weic/core/services/login_services.dart';
import 'package:weic/core/views/home/home_view.dart';
import './views/login/login_view.dart';
import './views/register/register_view.dart';

class Weic extends StatelessWidget {
  const Weic({Key key}) : super(key: key);

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
        '/register': (_) => RegisterView()
      },
      home: FutureBuilder(
        future: getId(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  strokeWidth: 3.0,
                ),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              return HomeView(userId: snapshot.data);
            default:
              if (snapshot.hasData) {
                return HomeView(userId: snapshot.data);
              } else {
                return LoginView();
              }
          }
        },
      ),
    );
  }
}
