import 'package:flutter/material.dart';
import 'package:weic/core/components/home/home_body.dart';
import '../../models/user.dart';
import '../../storage/db_storage.dart';
import '../../views/login/login_view.dart';
import '../../components/home/appbar_component.dart';
import '../../components/home/drawer/drawer_body.dart';

class HomeView extends StatefulWidget {
  final int userId;
  const HomeView({
    Key key,
    this.userId,
  }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  User user;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<User> getUserData() async {
    User userData = await DbStorage().getUser(widget.userId);
    user = userData;
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getUserData(),
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
          default:
            if (snapshot.hasData) {
              return Scaffold(
                key: _scaffoldKey,
                appBar: AppBarComponent(
                  user: user,
                  context: context,
                  scaffoldKey: _scaffoldKey,
                ),
                drawer: Drawer(
                  child: DrawerBody(
                    user: user,
                  ),
                ),
                body: HomeBody(),
              );
            } else {
              return LoginView();
            }
        }
      },
    );
  }
}
