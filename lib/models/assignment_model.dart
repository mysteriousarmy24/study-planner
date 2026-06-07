import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssignmentModel {
  final String? id;
  final String name;
  final String description;
  final int duration;
  final DateTime date;
  final TimeOfDay time;

  AssignmentModel({
    required this.name,
    required this.description,
    required this.duration,
    required this.date,
    required this.time,
    required this.id,
  });

  //toJson
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'duration': duration,
      'date': Timestamp.fromDate(date),
      'time': {'hour': time.hour, 'minute': time.minute},
    };
  }

  //from Json
  factory AssignmentModel.fromJson(Map<String, dynamic> data) {
    return AssignmentModel(
      name: data['name'],
      description: data['description'],
      duration: data['duration'],
      date: (data['date'] as Timestamp).toDate(),
      time: TimeOfDay(
        hour: (data['time']?['hour'] ?? 0) as int,
        minute: (data['time']?['minute'] ?? 0) as int,
      ),
      id: data['id'] ?? '',
    );
  }
}
