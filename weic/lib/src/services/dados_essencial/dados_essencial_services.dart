import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:weic/src/models/student.dart';

class DadosEssenciaisServices {
  final _authInstance = FirebaseAuth.instance;
  final ImagePicker _imagePicker = ImagePicker();
  Future<XFile?> takePhotoFromCamera() async {
    XFile? imageSource = await _imagePicker.pickImage(
      source: ImageSource.camera,
      maxHeight: 300,
      maxWidth: 300,
    );
    return imageSource;
  }

  Future<File?> pickPhotoFromGalery() async {
    XFile? imageSource = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 300,
      maxWidth: 300,
    );
    if (imageSource != null) {
      File? croppedImg = await cropImage(imgFile: imageSource);
      return croppedImg;
    } else {
      return null;
    }
  }

  Future<String> uploadPhoto({
    required Student student,
    required File file,
  }) async {
    final _storageRef = FirebaseStorage.instance.ref();
    final _uploadTask = await _storageRef
        .child('studentsProfilePhotos')
        .child('student ${student.id}')
        .putFile(file);
    final _photoUrl = await _uploadTask.ref.getDownloadURL();
    return _photoUrl;
  }

  Future<bool?> updatePassword({required String newPassword}) async {
    await _authInstance.currentUser?.updatePassword(newPassword).then((_) {
      return true;
    }).catchError((errorReturn) {
      return false;
    });
    return null;
  }

  Future checkEmailVerification(
      {required User user, required bool isEmailVerified, Timer? timer}) async {
    await user.reload();
    isEmailVerified = user.emailVerified;
    if (isEmailVerified) timer!.cancel();
  }

  Future<File?> cropImage({required XFile imgFile}) async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: imgFile.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Ajuste da imagem',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      return croppedFile;
    }
    return null;
  }
}
