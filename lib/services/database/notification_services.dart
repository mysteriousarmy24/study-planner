import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:study_planner/models/Notification_model.dart';
import 'package:study_planner/services/database/assignment_sevices.dart';

class NotificationServices {
  final CollectionReference notifications = FirebaseFirestore.instance
      .collection('notifications');

  Future<void> storeOvrueAssigenmnets() async {
    try {
      final assignmentsMap = await AssignmentSevices()
          .getAssignmentsFromCourseName();
      for (final entry in assignmentsMap.entries) {
        final courseName = entry.key;
        final assignments = entry.value;
        for (final assignment in assignments) {
          final assignmentId = assignment.id ?? '';
          if (assignmentId.isEmpty ||
              !DateTime.now().isAfter(assignment.date)) {
            continue;
          }

          final notificationDoc = notifications.doc(assignmentId);
          final docSnapshot = await notificationDoc.get();
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

  //get notifications
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
