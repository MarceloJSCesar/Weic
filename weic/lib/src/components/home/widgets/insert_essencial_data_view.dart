import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weic/src/config/app_assetsnames.dart';
import 'package:weic/src/config/app_textstyles.dart';
import 'package:weic/src/models/student.dart';
import 'package:weic/src/services/home/dados_essencial/dados_essencial_services.dart';
import 'package:weic/src/services/home/home_services.dart';

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
  File? _imagePath = File('');
  bool isLoading = false;
  final _homeServices = HomeServices();
  final _nameTextController = TextEditingController();
  final _dadosEssenciasServices = DadosEssenciaisServices();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                _imagePath!.path.length != 0
                    ? CircleAvatar(
                        radius: 30,
                        backgroundImage: FileImage(File(_imagePath!.path)),
                      )
                    : CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(AppAssetsNames.boyImageUrl),
                      ),
                Divider(),
                Text('Carrega sua foto de:')
              ],
            ),
          ),
          Row(
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
                    onTap: _imagePath!.path.length > 0 &&
                            _nameTextController.text.length > 0
                        ? () async {
                            setState(() {
                              isLoading = true;
                            });
                            Student student = Student(
                              id: widget.student.id,
                              name: _nameTextController.text,
                              profilePhoto: _imagePath!.path,
                              password: widget.student.password,
                              schoolName: widget.student.schoolName,
                            );
                            await _homeServices
                                .sendEssentialStudentDataToFirebase(
                              student: student,
                            );
                            setState(() {
                              isLoading = false;
                              Navigator.of(context).pop();
                            });
                          }
                        : null,
                    child: Container(
                      width: 120,
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _imagePath!.path.length > 0 &&
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
    );
  }
}
