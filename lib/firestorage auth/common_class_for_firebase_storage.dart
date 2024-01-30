import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonFirebaseStorageRepositorProvider = Provider((ref) => CommonFirebaseStorageRepository(
  firebasestorage: FirebaseStorage.instance,
),);

class CommonFirebaseStorageRepository{
  final FirebaseStorage firebasestorage;

  CommonFirebaseStorageRepository({
    required this.firebasestorage,
});

  Future<String> storeFiletoFirebase(String ref,File file) async {
    UploadTask uploadTask = firebasestorage.ref().child(ref).putFile(file);
    TaskSnapshot snap = await uploadTask;
    String downloadurl = await snap.ref.getDownloadURL();
    return downloadurl;
  }
}