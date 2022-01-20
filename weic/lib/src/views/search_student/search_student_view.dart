import 'package:flutter/material.dart';
import 'package:weic/src/config/app_textstyles.dart';

class SearchStudentView extends StatelessWidget {
  const SearchStudentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _studentSearchTextEditingController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 35,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: TextField(
                  controller: _studentSearchTextEditingController,
                  style: AppTextStyles.searchStudentFieldTextStyle,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'exemplo: 10 ano',
                  ),
                ),
              ),
              if (_studentSearchTextEditingController.text.length > 3)
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[],
                    ),
                  ),
                ),
              if (_studentSearchTextEditingController.text.length <= 3)
                Center(
                  child:
                      Text('Display an image here showing to search for users'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
