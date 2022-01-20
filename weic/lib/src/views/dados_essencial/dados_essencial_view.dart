import 'package:flutter/material.dart';
import '../../models/student.dart';
import '../../components/insert_essential_data/widgets/insert_essencial_data_view.dart';

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
      body: SafeArea(
        child: InsertEssencialData(student: widget.student),
      ),
    );
  }
}
