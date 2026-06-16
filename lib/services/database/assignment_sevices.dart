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

  //all the assignmnets inside a course
  Stream<List<AssignmentModel>> getAssignments(String courseId) {
    try {
      final CollectionReference assignmentCollection = courseCollection
          .doc(courseId)
          .collection('assignment');
      return assignmentCollection.snapshots().map((snapshot) {
        return snapshot.docs
            .map(
              (doc) =>
                  AssignmentModel.fromJson(doc.data() as Map<String, dynamic>),
            )
            .toList();
      });
    } catch (e) {
      print("error in getting assignmnets from each course $e ");
      return Stream.empty();
    }
  }

  //get all the courses from course id
  Future<Map<String, List<AssignmentModel>>>
  getAssignmentsFromCourseName() async {
    try {
      final QuerySnapshot snapshot = await courseCollection.get();
      final Map<String, List<AssignmentModel>> assignmentsMap = {};
      for (final doc in snapshot.docs) {
        final String id = doc.id;
        final List<AssignmentModel> assignments = await getAssignments(
          id,
        ).first;

        assignmentsMap[doc['name']] = assignments;
      }
      return assignmentsMap;
    } catch (e) {
      print("error in geting assignments from course name $e");
      return {};
    }
  }
}
