import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
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

  Future<XFile?> pickPhotoFromGalery() async {
    XFile? imageSource = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 300,
      maxWidth: 300,
    );
    return imageSource;
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
  }

  Future checkEmailVerification(
      {required User user, required bool isEmailVerified, Timer? timer}) async {
    await user.reload();
    isEmailVerified = user.emailVerified;
    if (isEmailVerified) timer!.cancel();
  }
}
