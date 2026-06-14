import 'package:flutter/material.dart';
import 'package:study_planner/consts/Styles.dart';
import 'package:study_planner/models/courses_model.dart';
import 'package:study_planner/widget/custom_text_field.dart';

class AddNewAssigenment extends StatelessWidget {
  final Courses course;
  const AddNewAssigenment({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _titleController = TextEditingController();
    final TextEditingController _descriptionController =
        TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("Add new assignment", style: Styles.pageHeading),
          SizedBox(height: 20),
          Text(
            "Fill in the details below to add a new assignment. And start managing your study planner.",
          ),
          SizedBox(height: 20),
          CustomTextField(
            controller: _titleController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            label: "Assignment Title",
          ),
        ],
      ),
    );
  }
}
