import 'package:flutter/material.dart';

class SearchStudentView extends StatelessWidget {
  const SearchStudentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
