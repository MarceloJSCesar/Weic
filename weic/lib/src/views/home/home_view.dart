import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypton/crypton.dart';
import 'package:flutter/material.dart';
import 'package:weic/src/components/home/widgets/insert_essencial_data_view.dart';
import 'package:weic/src/config/app_assetsnames.dart';
import 'package:weic/src/services/home/home_services.dart';
import 'package:weic/src/views/login/login_view.dart';
import '../../models/student.dart';
import '../../components/home/body/home_body.dart';
import '../../components/home/drawer/drawer_body.dart';
import 'package:uuid/uuid.dart';

class HomeView extends StatefulWidget {
  final String studentID;
  const HomeView({
    Key? key,
    required this.studentID,
  }) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _homeServices = HomeServices();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future:
          _homeServices.getStudentEssentialData(studentID: widget.studentID),
      builder: (context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                strokeWidth: 3.0,
              ),
            );

          default:
            if (snapshot.hasData) {
              print('snapshot data: ${snapshot.data}');
              final student = Student.fromDocument(snapshot.data);
              print(student.toString());
              return Scaffold(
                key: _scaffoldKey,
                body: HomeBody(
                  scaffoldKey: _scaffoldKey,
                  student: student,
                ),
              );
            } else {
              return LoginView();
            }
        }
      },
    );
  }
}
