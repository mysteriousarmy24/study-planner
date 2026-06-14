import 'package:flutter/material.dart';
import 'package:study_planner/consts/Styles.dart';
import 'package:study_planner/models/courses_model.dart';
import 'package:study_planner/widget/custom_text_field.dart';

class AddNewAssigenment extends StatefulWidget {
  final Courses course;
  const AddNewAssigenment({super.key, required this.course});

  @override
  State<AddNewAssigenment> createState() => _AddNewAssigenmentState();
}

class _AddNewAssigenmentState extends State<AddNewAssigenment> {
  TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Add New Assignment", style: Styles.pageHeading),
            SizedBox(height: 10),
            Text(
              "Fill in the details below to add a new assignment. And start managing your study planner.",
              style: Styles.bodyText,
            ),
            SizedBox(height: 10),
            CustomTextField(
              controller: _textEditingController,
              label: 'Name',
              keyboardType: TextInputType.name,
            ),
          ],
        ),
      ),
    );
  }
}
