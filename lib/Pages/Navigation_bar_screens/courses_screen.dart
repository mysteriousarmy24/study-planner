import 'package:flutter/material.dart';
import 'package:study_planner/consts/Styles.dart';
import 'package:study_planner/models/assignment_model.dart';
import 'package:study_planner/models/courses_model.dart';
import 'package:study_planner/models/note_model.dart';
import 'package:study_planner/services/database/assignment_sevices.dart';
import 'package:study_planner/services/database/courese_services.dart';
import 'package:study_planner/services/database/note_services.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});
  Future<Map<String, dynamic>> _fetchData() async {
    try {
      final courses = await CoureseServices().getCourses();
      final assignments = await AssignmentSevices()
          .getAssignmentsFromCourseName();
      final notes = await NoteServices().getNotesFromCourseName();
      return {'course': courses, 'assignments': assignments, 'notes': notes};
    } catch (e) {
      print("$e");
      return {'course': [], 'assignments': {}, 'notes': {}};
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          children: [
            Text("Courses ", style: Styles.sectionTitle),
            FutureBuilder(
              future: _fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('${snapshot.error}'));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text("No data"));
                }
                final coursesList =
                    snapshot.data!['course'] as List<Courses>? ?? [];
                final assignmentsMap =
                    snapshot.data!['assignments']
                        as Map<String, List<AssignmentModel>>? ??
                    {};
                final notesMap =
                    snapshot.data!['notes'] as Map<String, List<Note>>? ?? {};
                if (coursesList.isNotEmpty) {
                  return ListView.builder(
                    itemCount: coursesList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.all(15),
                    itemBuilder: (context, index) {
                      final course = coursesList[index];
                      final assignment = assignmentsMap[course.name] ?? [];
                      final note = notesMap[course.name] ?? [];
                      return Card(
                        child: Column(
                          children: [
                            Text(course.name, style: Styles.cardTitle),
                            SizedBox(height: 10),
                            Text(course.description, style: Styles.bodyText),
                            SizedBox(height: 10),
                            Text(
                              "Durtion ${course.duration}",
                              style: Styles.sectionSubtitle,
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Schedule ${course.schedule}",
                              style: Styles.sectionSubtitle,
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Instructor ${course.instructor}",
                              style: Styles.sectionSubtitle,
                            ),
                            SizedBox(height: 20),
                            Text(
                              "Assignments",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.greenAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            assignment.isNotEmpty
                                ? ListView.builder(
                                    itemCount: assignment.length,
                                    itemBuilder: (context, index) {
                                      final singleAssignment =
                                          assignment[index];
                                      return Card(
                                        child: ListTile(
                                          title: Text(singleAssignment.name),
                                          subtitle: Text(
                                            'Due Date ${singleAssignment.date}',
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Text("No assignments avalable"),
                                  ),
                            SizedBox(height: 10),
                          ],
                        ),
                      );
                    },
                  );
                }
                return Center(child: Text("No courses"));
              },
            ),
          ],
        ),
      ),
    );
  }
}
