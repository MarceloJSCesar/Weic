import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:weic/src/config/app_assetsnames.dart';
import 'package:weic/src/config/app_textstyles.dart';
import 'package:weic/src/services/home/dados_essencial/dados_essencial_services.dart';

class InsertEssencialData extends StatefulWidget {
  const InsertEssencialData({Key? key}) : super(key: key);

  @override
  _InsertEssencialDataState createState() => _InsertEssencialDataState();
}

class _InsertEssencialDataState extends State<InsertEssencialData> {
  File? _imagePath = File('');
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
          Container(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 120,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blue,
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
          ),
          SizedBox(height: 16)
        ],
      ),
    );
  }
}
