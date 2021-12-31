import 'package:flutter/material.dart';
import 'package:weic/src/components/home/widgets/insert_essencial_data_view.dart';
import 'package:weic/src/models/student.dart';

class DadosEssenciaisView extends StatefulWidget {
  final Student student;
  const DadosEssenciaisView({
    Key? key,
    required this.student,
  }) : super(key: key);

  @override
  _DadosEssenciaisViewState createState() => _DadosEssenciaisViewState();
}

class _DadosEssenciaisViewState extends State<DadosEssenciaisView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: InsertEssencialData(student: widget.student),
    );
  }
}
