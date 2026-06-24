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
    return Scaffold(
      appBar: AppBar(title: Text("Assignments", style: Styles.pageHeading)),
      body: FutureBuilder<Map<String, List<AssignmentModel>>>(
        future: _fetchAssigenments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No assignments found."));
          }

          final assignmentsList = snapshot.data!;
          return ListView.builder(
            itemCount: assignmentsList.length,
            itemBuilder: (context, index) {
              final courseName = assignmentsList.keys.elementAt(index);
              final assignments = assignmentsList[courseName] ?? [];
              return ExpansionTile(
                title: Text(courseName),
                children: assignments.map((assignment) {
                  return ListTile(
                    title: Text(
                      assignment.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Duration: ${assignment.duration} hours",
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Date: ${assignment.date.toLocal().toString().split(' ')[0]}",
                          style: TextStyle(fontSize: 12),
                        ),
                        SizedBox(height: 4),
                        Text(assignment.description, style: Styles.bodyText),
                      ],
                    ),

                    // trailing: Text(
                    //   "${assignment.date.toLocal()} ${assignment.time}",
                    // ),
                  );
                }).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
