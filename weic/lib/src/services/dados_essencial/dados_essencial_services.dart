import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypton/crypton.dart';
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
    RSAKeypair rsaKeypair = RSAKeypair.fromRandom();
    final encrypedPassword = rsaKeypair.publicKey.encrypt(newPassword);
    await _authInstance.currentUser?.updatePassword(encrypedPassword).then((_) {
      return true;
    }).catchError((errorReturn) {
      return false;
    });
  }
}
