import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageServices {
  //firebase instance
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage({required noteImage, required courseId}) async {
    try {
      // Use timestamp-based filename to avoid invalid characters in path
      String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage
          .ref()
          .child('note-images')
          .child(courseId)
          .child('$timestamp.jpg');

      UploadTask task = ref.putFile(
        noteImage,
        SettableMetadata(contentType: 'image/jpeg'),
      );

      TaskSnapshot snapShot = await task;

      String downloadUrl = await snapShot.ref.getDownloadURL();

      return downloadUrl;
    } catch (error) {
      print("ERRRRRRRRRRRRROR $error");
      return '';
    }
  }
}
