import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_planner/models/Notification_model.dart';
import 'package:study_planner/services/database/assignment_sevices.dart';

// Service responsible for creating and reading notification documents.
// In this app notifications are simply Firestore documents in a
// top-level `notifications` collection. The `storeOvrueAssigenmnets`
// method finds overdue assignments and writes a notification document
// for each one.
class NotificationServices {
  final CollectionReference notifications = FirebaseFirestore.instance
      .collection('notifications');

  // Find assignments that are overdue and create a notification
  // document for each one if it doesn't already exist.
  //
  // NOTE: Running this on the client is fine for demos, but in
  // production you may prefer a scheduled Cloud Function to avoid
  // relying on users' devices to detect overdue items.
  Future<void> storeOvrueAssigenmnets() async {
    try {
      final assignmentsMap = await AssignmentSevices()
          .getAssignmentsFromCourseName();
      for (final entry in assignmentsMap.entries) {
        final courseName = entry.key;
        final assignments = entry.value;
        for (final assignment in assignments) {
          final assignmentId = assignment.id ?? '';
          // Skip if there is no ID or if the assignment is not overdue
          if (assignmentId.isEmpty ||
              !DateTime.now().isAfter(assignment.date)) {
            continue;
          }

          final notificationDoc = notifications.doc(assignmentId);
          final docSnapshot = await notificationDoc.get();
          // Only create a notification if one doesn't already exist
          if (!docSnapshot.exists) {
            final notificationData = NotificationModel(
              assignmentId: assignmentId,
              assignmentName: assignment.name,
              courseName: courseName,
              description: assignment.description,
              dueDate: assignment.date,
              timePassed: ' Overdue',
            );

            await notificationDoc.set(notificationData.toJson());
            print('notification stored');
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  // Fetch notifications once. If you want real-time updates use
  // `.snapshots()` instead of `.get()` and map the QuerySnapshot.
  Future<List<NotificationModel>> getNotifications() async {
    try {
      final QuerySnapshot snapshot = await notifications.get();
      return snapshot.docs
          .map(
            (doc) =>
                NotificationModel.fromJson(doc.data() as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      print("error to get notifications $e");
      return [];
    }
  }
}
