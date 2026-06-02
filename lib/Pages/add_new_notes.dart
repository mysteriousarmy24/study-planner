import 'package:flutter/material.dart';
import 'package:study_planner/consts/Styles.dart';
import 'package:study_planner/models/courses_model.dart';
import 'package:study_planner/widget/custom_text_field.dart';
import 'package:study_planner/widget/cutom_button.dart';

class AddNewNotes extends StatelessWidget {
  final Courses course;
  AddNewNotes({super.key, required this.course});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noteTitleContraller = TextEditingController();
  final TextEditingController _noteDescriptionContraller =
      TextEditingController();
  final TextEditingController _noteSectionNameContraller =
      TextEditingController();
  final TextEditingController _noteReferenceBookContraller =
      TextEditingController();
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
                Text("Add new Notes to your course", style: Styles.pageHeading),
                SizedBox(height: 20),
                Text(
                  "Fill in the details below to add a new note. And start managing your study planner.",
                  style: Styles.bodyText,
                ),
                SizedBox(height: 20),
                Form(
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _noteTitleContraller,
                        label: "Note Title",
                        keyboardType: TextInputType.text,
                      ),
                      //SizedBox(height: 10),
                      CustomTextField(
                        controller: _noteDescriptionContraller,
                        label: "Note Description",
                        keyboardType: TextInputType.text,
                      ),
                      //SizedBox(height: 10),
                      CustomTextField(
                        controller: _noteSectionNameContraller,
                        label: "Note Section Name",
                        keyboardType: TextInputType.text,
                      ),
                      //SizedBox(height: 10),
                      CustomTextField(
                        controller: _noteReferenceBookContraller,
                        label: "Note Reference Book",
                        keyboardType: TextInputType.text,
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                Divider(color: Colors.grey),
                SizedBox(height: 10),
                Text(
                  "Upload Note Image , for better understanding and quick revision",
                  style: Styles.bodyText,
                ),
                SizedBox(height: 10),
                CustomElevatedButton(
                  text: "Upload Note Image",
                  onPressed: () {},
                ),
                SizedBox(height: 10),
                CustomElevatedButton(text: "Submit", onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
