import 'package:cloud_firestore/cloud_firestore.dart';

class AssignmentModel {
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
  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
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
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      duration: json['duration'] ?? 0,
      date: parsedDate,
      time: json['time'] ?? '',
    );
  }
}
