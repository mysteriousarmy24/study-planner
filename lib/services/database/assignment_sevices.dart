import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_planner/models/assignment_model.dart';

// Service class that encapsulates Firestore operations related to
// assignments. Keeping Firestore logic here (instead of UI code) makes
// it easier to test and maintain.
class AssignmentSevices {
  // Top-level `course` collection reference. Each course document
  // contains an `assignment` subcollection where assignment documents
  // are stored.
  final CollectionReference courseCollection = FirebaseFirestore.instance
      .collection("course");

  //creating new assignment to courese
  Future<void> createAssignment(
    String courseId,
    AssignmentModel assignment,
  ) async {
    try {
      // Convert the model to a JSON map suitable for Firestore.
      final Map<String, dynamic> data = assignment.toJson();

      // Each course document has an `assignment` subcollection.
      final CollectionReference assignmentCollection = courseCollection
          .doc(courseId)
          .collection('assignment');

      // Add a new document and then update it with its generated ID.
      // This pattern allows the app to later refer to the document by id.
      DocumentReference docRef = await assignmentCollection.add(data);
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
      // Listen to real-time updates using `.snapshots()` and map each
      // document to `AssignmentModel` using the factory method.
      return assignmentCollection.snapshots().map((snapshot) {
        return snapshot.docs
            .map(
              (doc) => AssignmentModel.fromJson(
                doc.data() as Map<String, dynamic>,
                doc.id,
              ),
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
        // Use the course document's `name` field as the map key and
        // the list of assignments as the value. This is a convenience
        // wrapper used by the UI — it fetches all courses and then the
        // assignments for each course.
        assignmentsMap[doc['name']] = assignments;
      }
      return assignmentsMap;
    } catch (e) {
      print("error in geting assignments from course name $e");
      return {};
    }
  }
}
