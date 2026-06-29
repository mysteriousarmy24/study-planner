import 'package:cloud_firestore/cloud_firestore.dart';

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
      'date': Timestamp.fromDate(date),
      'time': time,
    };
  }

  //from json
  factory AssignmentModel.fromJson(Map<String, dynamic> json, [String? docId]) {
    final dateValue = json['date'];
    DateTime parsedDate;

    if (dateValue is DateTime) {
      parsedDate = dateValue;
    } else if (dateValue is Timestamp) {
      parsedDate = dateValue.toDate();
    } else if (dateValue is String) {
      parsedDate = DateTime.tryParse(dateValue) ?? DateTime.now();
    } else {
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
