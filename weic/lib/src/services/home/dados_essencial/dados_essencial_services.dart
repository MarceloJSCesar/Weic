import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DadosEssenciaisServices {
  final ImagePicker _imagePicker = ImagePicker();
  Future<XFile?> takePhotoFromCamera() async {
    XFile? imageSource = await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 300,
      maxWidth: 300,
    );
    return imageSource;
  }

  Future<XFile?> pickPhotoFromGalery() async {
    XFile? imageSource = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 300,
      maxWidth: 300,
    );
    return imageSource;
  }
}
