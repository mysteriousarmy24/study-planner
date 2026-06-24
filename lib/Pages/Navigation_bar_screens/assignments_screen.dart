import 'package:flutter/material.dart';
import 'package:study_planner/consts/Styles.dart';
import 'package:study_planner/models/assignment_model.dart';
import 'package:study_planner/services/database/assignment_sevices.dart';

class AssignmentsScreen extends StatelessWidget {
  const AssignmentsScreen({super.key});
  Future<Map<String, List<AssignmentModel>>> _fetchAssigenments() async {
    return AssignmentSevices().getAssignmentsFromCourseName();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [Text("Assignments", style: Styles.pageHeading)],
        ),
      ),
    );
  }
}
