// Firestore Timestamp import — used to convert between Firestore and Dart
// date/time representations.
import 'package:cloud_firestore/cloud_firestore.dart';

// Model representing a notification stored in Firestore. Keep the mapping
// logic here so it's easy to understand how documents map to Dart objects.
class NotificationModel {
  final String assignmentId;
  final String assignmentName;
  final String courseName;
  final String description;
  final DateTime dueDate;
  final String timePassed;

  NotificationModel({
    required this.assignmentId,
    required this.assignmentName,
    required this.courseName,
    required this.description,
    required this.dueDate,
    required this.timePassed,
  });

  // Convert a Notification instance into a Map
  Map<String, dynamic> toJson() {
    return {
      'assignmentId': assignmentId,
      'assignmentName': assignmentName,
      'courseName': courseName,
      'description': description,
      // Convert `DateTime` to Firestore `Timestamp` when writing.
      'dueDate': Timestamp.fromDate(dueDate),
      'timePassed': timePassed,
    };
  }

  // Convert a Map into a Notification instance
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      assignmentId: json['assignmentId'] ?? '',
      assignmentName: json['assignmentName'] ?? '',
      courseName: json['courseName'] ?? '',
      description: json['description'] ?? '',
      // When reading the `dueDate` field from Firestore it's usually a
      // `Timestamp`. Cast safely and convert to `DateTime`. If your data
      // source might contain strings or missing fields, consider adding
      // extra checks like in `AssignmentModel.fromJson` above.
      dueDate: (json['dueDate'] as Timestamp).toDate(),
      timePassed: json['timePassed'] ?? '',
    );
  }
}
