import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner/Pages/consts/Styles.dart';
import 'package:study_planner/Pages/models/courses_model.dart';
import 'package:study_planner/Pages/widget/custom_text_field.dart';
import 'package:study_planner/Pages/widget/cutom_button.dart';
import 'package:study_planner/helpers/snakbar.dart';
import 'package:study_planner/services/courese_services.dart';

class AddNewCourse extends StatelessWidget {
  AddNewCourse({super.key});

  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseDescriptionController =
      TextEditingController();
  final TextEditingController _courseDurationController =
      TextEditingController();
  final TextEditingController _courseScheduleController =
      TextEditingController();
  final TextEditingController _courseInstructorController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> addCoure({
    String? name,
    String? description,
    int? duration,
    DateTime? schedule,
    String? instructor,
  }) async {
    final Courses newCourse = Courses(
      id: '',
      name: name ?? '',
      description: description ?? '',
      duration: duration ?? 0,
      schedule: schedule ?? DateTime.now(),
      instructor: instructor ?? '',
    );
    return CoureseServices().addCoures(newCourse);
  }

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
                Text("Courses", style: Styles.pageHeading),
                SizedBox(height: 10),
                Text(
                  "Your study planner helps you to keep track of your study progress and manage your time effectively.",
                  style: Styles.bodyText,
                ),
                SizedBox(height: 15),
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextField(
                          keyboardType: TextInputType.name,
                          controller: _courseNameController,
                          label: "Course Name",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter course name";
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          keyboardType: TextInputType.multiline,
                          controller: _courseDescriptionController,
                          label: "Course Description",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter course description";
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          keyboardType: TextInputType.number,
                          controller: _courseDurationController,
                          label: "Course Duration",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter course duration";
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          keyboardType: TextInputType.multiline,
                          controller: _courseScheduleController,
                          label: "Course Schedule",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter course schedule";
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          keyboardType: TextInputType.name,
                          controller: _courseInstructorController,
                          label: "Course Instructor",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter course instructor";
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomElevatedButton(
                  text: "Add Course",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addCoure(
                        name: _courseNameController.text,
                        description: _courseDescriptionController.text,
                        duration: int.tryParse(_courseDurationController.text),
                        schedule: DateTime.tryParse(_courseScheduleController.text),
                        instructor: _courseInstructorController.text,
                      );
                      GoRouter.of(context).pop();
                      showSnackBar(massege: "Coures added successfully...", context: context);
                      // Add course to database
                    } else {
                      showSnackBar(massege: "Fill the forms!!!", context: context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
