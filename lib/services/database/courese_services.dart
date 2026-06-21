import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_planner/models/courses_model.dart';

class CoureseServices {
  // reference to firestore
  final CollectionReference courseCollection = FirebaseFirestore.instance
      .collection("course");

  //method to add course
  Future<void> addCoures(Courses course) async {
    try {
      final Map<String, dynamic> data = course.toJson();
      //add course to data collection
      final DocumentReference docRef = await courseCollection.add(data);
      await docRef.update({'id': docRef.id});
      print("course saved");
    } catch (e) {
      print("Error in courses service/adding course $e");
    }
  }

  //get all the courses as stream
  Stream<List<Courses>> get courses {
    try {
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
