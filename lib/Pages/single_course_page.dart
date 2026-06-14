import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner/consts/Styles.dart';
import 'package:study_planner/consts/colors.dart';
import 'package:study_planner/models/assignment_model.dart';
import 'package:study_planner/models/courses_model.dart';

class SingleCoursePage extends StatelessWidget {
  final Courses course;

  const SingleCoursePage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course.name, style: Styles.pageHeading),
                SizedBox(height: 10),
                Text("Instructor ${course.instructor}", style: Styles.bodyText),
                SizedBox(height: 5),
                Text("Duration ${course.duration}", style: Styles.bodyText),
                SizedBox(height: 5),
                Text("Schedule ${course.schedule}", style: Styles.bodyText),
                SizedBox(height: 10),
                Text("Description", style: Styles.sectionTitle),
                SizedBox(height: 10),
                Text(course.description, style: Styles.bodyText),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //!add Assignment
                    GestureDetector(
                      onTap: () => GoRouter.of(
                        context,
                      ).push("/new-assignment", extra: course),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: lightGreen,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 40,
                            horizontal: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Add Asignment",
                                style: Styles.cardTitle.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Add a new assignment to this course and set adeadline.Also you can add a description to the assignment. ',
                                style: Styles.cardSubtitle.copyWith(
                                  color: const Color.fromARGB(
                                    255,
                                    31,
                                    45,
                                    53,
                                  ).withValues(alpha: 0.8),
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    //!add notes
                    GestureDetector(
                      onTap: () => GoRouter.of(
                        context,
                      ).push("/new-notes", extra: course),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: MediaQuery.of(context).size.width * 0.45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: lightGreen,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 40,
                            horizontal: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Add Notes",
                                style: Styles.cardTitle.copyWith(
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Add notes to this course to help you remember important points and topics.And you can also add images and links. ',
                                style: Styles.cardSubtitle.copyWith(
                                  color: const Color.fromARGB(
                                    255,
                                    31,
                                    45,
                                    53,
                                  ).withValues(alpha: 0.8),
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(15),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(primaryColor),
                  ),
                  child: Text("Delete Course", style: Styles.buttonText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
