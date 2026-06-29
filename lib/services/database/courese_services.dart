import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_planner/models/courses_model.dart';

// Service for working with the top-level `course` collection. It
// encapsulates common CRUD patterns so the UI code doesn't need to
// know Firestore details.
class CoureseServices {
  // Reference to the `course` collection in Firestore.
  final CollectionReference courseCollection = FirebaseFirestore.instance
      .collection("course");

  //method to add course
  Future<void> addCoures(Courses course) async {
    try {
      // Convert the model to a map and add a new document.
      final Map<String, dynamic> data = course.toJson();
      final DocumentReference docRef = await courseCollection.add(data);

      // Update the newly created document with its own ID. This is a
      // common pattern for convenience, allowing the model to include
      // its document ID as a field.
      await docRef.update({'id': docRef.id});
      print("course saved");
    } catch (e) {
      print("Error in courses service/adding course $e");
    }
  }

  //get all the courses as stream
  Stream<List<Courses>> get courses {
    try {
      // Real-time stream of courses — the UI can listen to this stream
      // to receive live updates when courses are added/changed/removed.
      return courseCollection.snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) => Courses.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (e) {
      print("Error in stream of courses $e");
      return Stream.empty();
    }
  }

  Future<List<Courses>> getCourses() async {
    try {
      final QuerySnapshot snapshot = await courseCollection.get();
      return snapshot.docs.map((doc) {
        return Courses.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      print("Error i n course services $e");
      return [];
    }
  }
}
