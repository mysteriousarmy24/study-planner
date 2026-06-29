// Cloud Firestore Timestamp helper import. Firestore stores date/time as
// `Timestamp` objects; when mapping to Dart models we usually convert to
// `DateTime` and back when writing.
import 'package:cloud_firestore/cloud_firestore.dart';

// Model representing an assignment document saved in Firestore.
// When reading/writing documents you convert between Map<String, dynamic>
// and this model using `fromJson` and `toJson` below.
class AssignmentModel {
  final String? id;
  final String name;
  final String description;
  final int duration;
  final DateTime date;
  final String time;

  AssignmentModel({
    required this.name,
    required this.description,
    required this.duration,
    required this.date,
    required this.time,
    this.id,
  });
  //to Json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'duration': duration,
      // Convert `DateTime` to Firestore `Timestamp` before writing.
      // Firestore does not store DateTime directly.
      'date': Timestamp.fromDate(date),
      'time': time,
    };
  }

  //from json
  factory AssignmentModel.fromJson(Map<String, dynamic> json, [String? docId]) {
    final dateValue = json['date'];
    DateTime parsedDate;

    // Firestore sometimes returns a `Timestamp`, but code paths or tests
    // might also supply `DateTime` or an ISO string. Handle all cases
    // robustly so your app doesn't crash when the stored value format
    // differs.
    if (dateValue is DateTime) {
      parsedDate = dateValue;
    } else if (dateValue is Timestamp) {
      parsedDate = dateValue.toDate();
    } else if (dateValue is String) {
      // Try parsing ISO date strings, fallback to now on failure.
      parsedDate = DateTime.tryParse(dateValue) ?? DateTime.now();
    } else {
      // If the field is missing or an unexpected type, use a sensible
      // default to avoid exceptions. You can change this to null and
      // make the field nullable if preferred.
      parsedDate = DateTime.now();
    }

    return AssignmentModel(
      id: json['id'] ?? docId,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      duration: json['duration'] ?? 0,
      date: parsedDate,
      time: json['time'] ?? '',
    );
  }
}
