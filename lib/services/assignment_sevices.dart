import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_planner/models/assignment_model.dart';

class AssignmentSevices {
  //creating a firestore reference
  final CollectionReference courseCollection = FirebaseFirestore.instance
      .collection("course");

  //creating new assignment to courese
  Future<void> createAssignment(
    String courseId,
    AssignmentModel assignment,
  ) async {
    try {
      final Map<String, dynamic> data = assignment.toJson();
      final CollectionReference assignmentCollection = courseCollection
          .doc(courseId)
          .collection('assignment');
      DocumentReference docRef = await assignmentCollection.add(data);
      //update the assignment ID with document ID
      await docRef.update({'id': docRef.id});
    } catch (e) {
      print("Error in creating assignment....$e");
    }
  }
}
