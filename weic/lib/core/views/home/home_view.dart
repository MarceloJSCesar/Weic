import 'package:flutter/material.dart';
import 'package:weic/core/config/app_textstyles.dart';
import 'package:weic/core/models/user.dart';
import 'package:weic/core/services/login_services.dart';
import 'package:weic/core/storage/db_storage.dart';
import 'package:weic/core/views/login/login_view.dart';

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
          case ConnectionState.active:
          case ConnectionState.done:
            return Center(
                child: Text(
              user.name.toString(),
              style: AppTextStyles.hintTextStyle,
            ));
          default:
            if (snapshot.hasData) {
              return Center(
                  child: Text(user.name, style: AppTextStyles.hintTextStyle));
            } else {
              return LoginView();
            }
        }
      },
    );
  }
}
