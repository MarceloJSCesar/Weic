import 'package:flutter/material.dart';
import 'package:weic/src/models/student.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
              'Email: ${widget.student.email} and Password: ${widget.student.password}')),
    );
  }
}
