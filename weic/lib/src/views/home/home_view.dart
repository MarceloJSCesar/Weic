import 'package:flutter/material.dart';
import 'package:weic/src/services/home/home_services.dart';
import '../../models/student.dart';
import '../../components/home/body/home_body.dart';
import '../../components/home/drawer/drawer_body.dart';

class HomeView extends StatefulWidget {
  final Student? student;
  const HomeView({
    Key? key,
    this.student,
  }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    HomeServices().getSapoNews().then((value) => print('value: $value'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: DrawerBody(),
      ),
      body: HomeBody(scaffoldKey: _scaffoldKey),
    );
  }
}
