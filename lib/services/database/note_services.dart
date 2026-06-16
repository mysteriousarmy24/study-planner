import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_planner/models/note_model.dart';
import 'package:study_planner/services/cloud_storage/storage.dart';

class NoteServices {
  //firbase instanse
  final CollectionReference courseCollection = FirebaseFirestore.instance
      .collection('courses');

  //Store notes
  Future<void> createNote(String courseId, Note note) async {
    try {
      String? imageUrl;
      if (note.imageData != null) {
        try {
          String uploadedUrl = await StorageServices().uploadImage(
            noteImage: note.imageData,
            courseId: courseId,
          );
          // Only set imageUrl if upload was successful (non-empty)
          imageUrl = uploadedUrl.isNotEmpty ? uploadedUrl : null;
        } catch (uploadError) {
          print(
            "Warning: Image upload failed, saving note without image: $uploadError",
          );
          imageUrl = null;
        }
      }
      //creating new note obj
      final Note newNote = Note(
        imageUrl: imageUrl,
        title: note.title,
        description: note.description,
        sectionName: note.sectionName,
        referenceBooks: note.referenceBooks,
        id: ' ',
      );

      final Map<String, dynamic> data = newNote.toJson();
      final CollectionReference noteCollection = courseCollection
          .doc(courseId)
          .collection('note');
      DocumentReference docRef = await noteCollection.add(data);
      //Update note ID with doument ID
      await docRef.update({'id': docRef.id});
    } catch (e) {
      print("Error in store notes $e");
      rethrow; // Re-throw to let the UI handle the error
    }
  }

  //getting list of notes by course id
  Stream<List<Note>> getNotes(String courseId) {
    try {
      final CollectionReference noteCollection = courseCollection
          .doc(courseId)
          .collection('note');
      return noteCollection.snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => Note.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (e) {
      print("error in note services get notes by id $e");
      return Stream.empty();
    }
  }

  Future<Map<String, List<Note>>> getNotesFromCourseName(String name) async {
    try {
      final QuerySnapshot snapshot = await courseCollection.get();
      final Map<String, List<Note>> notesMap = {};
      for (final doc in snapshot.docs) {
        final String id = doc.id;
        final List<Note> notes = await getNotes(id).first;
        notesMap[doc['name']] = notes;
      }
      return notesMap;
    } catch (e) {
      print("$e");
      return {};
    }
  }
}
