import 'package:flutter/material.dart';
import '../../models/student.dart';
import '../../views/splash/splash_view.dart';
import '../../services/home/home_services.dart';
import '../../components/home/body/home_body.dart';

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
              final student = Student.fromDocument(snapshot.data);
              return Scaffold(
                key: _scaffoldKey,
                body: HomeBody(
                  scaffoldKey: _scaffoldKey,
                  student: student,
                ),
              );
            } else {
              return SplashView();
            }
        }
      },
    );
  }
}
