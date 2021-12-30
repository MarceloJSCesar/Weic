import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypton/crypton.dart';
import 'package:flutter/material.dart';
import 'package:weic/src/components/home/widgets/insert_essencial_data_view.dart';
import 'package:weic/src/config/app_assetsnames.dart';
import 'package:weic/src/services/home/home_services.dart';
import '../../models/student.dart';
import '../../components/home/body/home_body.dart';
import '../../components/home/drawer/drawer_body.dart';
import 'package:uuid/uuid.dart';

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
  final _homeServices = HomeServices();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _homeServices.getStudentEssentialData(student: widget.student).then(
      (value) {
        if (value == null) {
          showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text('Dados Essenciais'),
                content: InsertEssencialData(
                  student: widget.student,
                ),
              );
            },
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(child: DrawerBody()),
      body: FutureBuilder(
          future:
              _homeServices.getStudentEssentialData(student: widget.student),
          builder: (context, snapshot) {
            print('snapshot data: ${snapshot.data}');
            return HomeBody(
              scaffoldKey: _scaffoldKey,
              student: widget.student,
            );
          }),
    );
  }
}
