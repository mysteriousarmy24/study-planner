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

      // Ensure upload completed successfully before getting URL
      if (snapShot.state == TaskState.success) {
        String downloadUrl = await snapShot.ref.getDownloadURL();
        print("Image uploaded successfully: $downloadUrl");
        return downloadUrl;
      } else {
        print("ERROR: Upload failed with state ${snapShot.state}");
        return '';
      }
    } catch (error) {
      print("ERROR uploading image: $error");
      rethrow; // Re-throw to let caller handle it
    }
  }

  /// Verify if a stored image URL still exists in Firebase Storage
  Future<bool> imageExists(String imageUrl) async {
    try {
      Reference ref = _storage.refFromURL(imageUrl);
      await ref.getMetadata();
      return true;
    } catch (e) {
      print("Image not found at URL: $e");
      return false;
    }
  }
}
