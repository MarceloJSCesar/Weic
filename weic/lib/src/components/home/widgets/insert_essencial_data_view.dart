import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weic/src/config/app_assetsnames.dart';
import 'package:weic/src/config/app_textstyles.dart';
import 'package:weic/src/models/student.dart';
import 'package:weic/src/services/home/dados_essencial/dados_essencial_services.dart';
import 'package:weic/src/services/home/home_services.dart';
import 'package:weic/src/views/app_view.dart';

class InsertEssencialData extends StatefulWidget {
  final Student student;
  const InsertEssencialData({
    Key? key,
    required this.student,
  }) : super(key: key);

  @override
  _InsertEssencialDataState createState() => _InsertEssencialDataState();
}

class _InsertEssencialDataState extends State<InsertEssencialData> {
  File _imagePath = File('');
  bool isLoading = false;
  final _homeServices = HomeServices();
  final _nameTextController = TextEditingController();
  final _dadosEssenciasServices = DadosEssenciaisServices();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Dados Essenciais',
                      style: AppTextStyles.titleBlackTextStyle,
                    ),
                  ),
                  SizedBox(height: 30),
                  _imagePath.path.length != 0
                      ? CircleAvatar(
                          radius: 30,
                          backgroundImage: FileImage(File(_imagePath.path)),
                        )
                      : CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage(AppAssetsNames.boyImageUrl),
                        ),
                  Divider(),
                  Text('Carrega sua foto de:')
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton.icon(
                  onPressed: () async {
                    XFile? xFileImage =
                        await _dadosEssenciasServices.takePhotoFromCamera();
                    setState(() {
                      _imagePath = File(xFileImage!.path);
                    });
                  },
                  icon: Text('Camera'),
                  label: Icon(Icons.camera),
                ),
                TextButton.icon(
                  onPressed: () async {
                    XFile? xFileImage =
                        await _dadosEssenciasServices.pickPhotoFromGalery();
                    setState(() {
                      _imagePath = File(xFileImage!.path);
                    });
                  },
                  icon: Text('Galeria'),
                  label: Icon(Icons.photo_library),
                ),
              ],
            ),
            Divider(),
            TextFormField(
              controller: _nameTextController,
              textCapitalization: TextCapitalization.words,
              onChanged: (val) {
                setState(() {});
              },
              decoration: InputDecoration(
                labelText: 'Primeiro e Segundo nome',
                hintText: 'ex: Marcelo Cesar',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            isLoading == false
                ? Container(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: _imagePath.path.length > 0 &&
                              _nameTextController.text.length > 0
                          ? () async {
                              setState(() {
                                isLoading = true;
                              });
                              final _prefs =
                                  await SharedPreferences.getInstance();
                              final studentID = _prefs.getString('STUDENT_ID');
                              final String _studentProfileImgUrl =
                                  await _dadosEssenciasServices.uploadPhoto(
                                student: widget.student,
                                file: _imagePath,
                              );
                              Student student = Student(
                                id: widget.student.id,
                                email: widget.student.email,
                                name: _nameTextController.text,
                                password: widget.student.password,
                                profilePhoto: _studentProfileImgUrl,
                                schoolName: widget.student.schoolName,
                              );
                              await _homeServices
                                  .sendEssentialStudentDataToFirebase(
                                student: student,
                              );
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (_) => AppView(
                                    studentID: studentID as String,
                                  ),
                                ),
                              );
                            }
                          : null,
                      child: Container(
                        width: 120,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _imagePath.path.length > 0 &&
                                  _nameTextController.text.length > 2
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Guardar',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.dadosEssenciaisButtonTextStyle,
                        ),
                      ),
                    ),
                  )
                : Container(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
            SizedBox(height: 16)
          ],
        ),
      ),
    );
  }
}
