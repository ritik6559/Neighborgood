import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:neighborgood/common/utils/show_snackbar.dart';

class StorageRepository {
  final FirebaseStorage _firebaseStorage;

  StorageRepository({
    required FirebaseStorage firebaseStorage,
  }) : _firebaseStorage = firebaseStorage;

  Future<String?> storeFile({
    required String path,
    required String id,
    required File? file,
    required BuildContext context,
  }) async {
    try {
      //example:- user/banner/123 means banner image will be stored in the user folder in banner sub-folder with id 123
      final ref = _firebaseStorage.ref().child(path).child(id);

      UploadTask uploadTask;
      uploadTask = ref.putFile(file!);

      final snapshot = await uploadTask;
      print(snapshot.ref.getDownloadURL());

      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
        'Oh Snap!',
      );
      return null;
    }
  }
}
