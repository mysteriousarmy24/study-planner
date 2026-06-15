import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner/consts/Styles.dart';
import 'package:study_planner/helpers/snakbar.dart';
import 'package:study_planner/models/assignment_model.dart';
import 'package:study_planner/models/courses_model.dart';
import 'package:study_planner/services/database/assignment_sevices.dart';
import 'package:study_planner/widget/custom_text_field.dart';
import 'package:study_planner/widget/cutom_button.dart';

class AddNewAssigenment extends StatelessWidget {
  final Courses course;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _assignmentNameContraller =
      TextEditingController();
  final TextEditingController _descriptionContraller = TextEditingController();
  final TextEditingController _durationgContraller = TextEditingController();

  //? UPDATE THE DATE AND TIME PICKER TO USE VALUE NOTIFIER TO UPDATE THE UI WHENEVER THE USER SELECT A NEW DATE OR TIME
  final ValueNotifier<DateTime> _selectedDate = ValueNotifier<DateTime>(
    DateTime.now(),
  );
  final ValueNotifier<TimeOfDay> _selectedTime = ValueNotifier<TimeOfDay>(
    TimeOfDay.now(),
  );

  //*Initilize the constructer to set the initial value of the date and time pickers to the current date and time
  AddNewAssigenment({super.key, required this.course}) {
    _selectedDate.value = DateTime.now();
    _selectedTime.value = TimeOfDay.now();
  }

  //Form validations
  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final AssignmentModel assignment = AssignmentModel(
        name: _assignmentNameContraller.text,
        description: _descriptionContraller.text,
        duration: int.tryParse(_durationgContraller.text) ?? 0,
        date: _selectedDate.value.toLocal().toString().split(' ')[0],
        time: _selectedTime.value.format(context),
      );
      AssignmentSevices().createAssignment(course.id, assignment);
      showSnackBar(massege: "Assignment Added..", context: context);
      GoRouter.of(context).pop();
      try {
        // TODO: add assignment saving logic here
      } catch (error) {
        print('Error in adding new assignment.dart --_submitForm');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add assignments")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fill in the details below to add a new assignment. And start managing your study planner.",
                      style: Styles.bodyText,
                    ),
                    SizedBox(height: 30),
                    CustomTextField(
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Enter Assignment Name";
                        }
                        return null;
                      },
                      controller: _assignmentNameContraller,
                      label: "Assignment name",
                      keyboardType: TextInputType.name,
                    ),
                    CustomTextField(
                      validator: (p0) => (p0?.isEmpty ?? true)
                          ? "Enter Assignment Description"
                          : null,
                      controller: _descriptionContraller,
                      label: "Assignment Description",
                      keyboardType: TextInputType.text,
                    ),
                    CustomTextField(
                      validator: (p0) =>
                          (p0?.isEmpty ?? true) ? "Enter Duration" : null,
                      controller: _durationgContraller,
                      label: "Duration(1 hour )",
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 30),
                    Divider(color: Colors.grey),
                    SizedBox(height: 10),
                    Text("Due Date and Time", style: Styles.noteText),
                    SizedBox(height: 10),
                    ValueListenableBuilder<DateTime>(
                      valueListenable: _selectedDate,
                      builder: (context, date, child) {
                        return Row(
                          children: [
                            Text(
                              "Date: ${date.toLocal().toString().split(' ')[0]}",
                              style: Styles.bodyText,
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.calendar_today),
                              onPressed: () async {
                                final DateTime? pickedDate =
                                    await showDatePicker(
                                      context: context,
                                      initialDate: _selectedDate.value,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2100),
                                    );
                                if (pickedDate != null) {
                                  _selectedDate.value = pickedDate;
                                }
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 10),
                    ValueListenableBuilder<TimeOfDay>(
                      valueListenable: _selectedTime,
                      builder: (context, time, child) {
                        return Row(
                          children: [
                            Text(
                              "Time: ${time.format(context)}",
                              style: Styles.bodyText,
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.access_time),
                              onPressed: () async {
                                final TimeOfDay? pickedTime =
                                    await showTimePicker(
                                      context: context,
                                      initialTime: _selectedTime.value,
                                    );
                                if (pickedTime != null) {
                                  _selectedTime.value = pickedTime;
                                }
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(height: 30),
                    CustomElevatedButton(
                      text: "add Assignment",
                      onPressed: () => _submitForm(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
