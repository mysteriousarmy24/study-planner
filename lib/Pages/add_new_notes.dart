import 'package:flutter/material.dart';
import 'package:study_planner/models/courses_model.dart';

class AddNewNotes extends StatefulWidget {
  final Courses course;
  const AddNewNotes({super.key, required this.course});

  @override
  State<AddNewNotes> createState() => _AddNewNotesState();
}

class _AddNewNotesState extends State<AddNewNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar());
  }
}
