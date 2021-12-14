import 'package:flutter/material.dart';
import '../../models/student.dart';
import '../../components/home/body/home_body.dart';
import '../../components/home/drawer/drawer_body.dart';
import '../../components/home/widgets/app_bar_component.dart';

class HomeView extends StatefulWidget {
  final Student student;
  const HomeView({
    Key? key,
    required this.student,
  }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarComponent(
        context: context,
        scaffoldKey: _scaffoldKey,
      ),
      drawer: Drawer(
        child: DrawerBody(),
      ),
      body: HomeBody(),
    );
  }
}
