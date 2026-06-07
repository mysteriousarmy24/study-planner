import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study_planner/consts/Styles.dart';
import 'package:study_planner/models/courses_model.dart';
import 'package:study_planner/widget/custom_text_field.dart';
import 'package:study_planner/widget/cutom_button.dart';

class AddNewNotes extends StatefulWidget {
  final Courses course;
  const AddNewNotes({super.key, required this.course});

  @override
  State<AddNewNotes> createState() => _AddNewNotesState();
}

class _AddNewNotesState extends State<AddNewNotes> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _noteTitleContraller = TextEditingController();

  final TextEditingController _noteDescriptionContraller =
      TextEditingController();

  final TextEditingController _noteSectionNameContraller =
      TextEditingController();

  final TextEditingController _noteReferenceBookContraller =
      TextEditingController();

  //image picker
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _selectedImage;
  Future<void> _pickImage() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _selectedImage = image;
    });
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
                Text("Add new Notes to your course", style: Styles.pageHeading),
                SizedBox(height: 20),
                Text(
                  "Fill in the details below to add a new note. And start managing your study planner.",
                  style: Styles.bodyText,
                ),
                SizedBox(height: 20),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _noteTitleContraller,
                        label: "Note Title",
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return " Enter a Title";
                          } else {
                            return null;
                          }
                        },
                      ),
                      //SizedBox(height: 10),
                      CustomTextField(
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return " Enter a Title";
                          } else {
                            return null;
                          }
                        },
                        controller: _noteDescriptionContraller,
                        label: "Note Description",
                        keyboardType: TextInputType.text,
                      ),
                      //SizedBox(height: 10),
                      CustomTextField(
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return " Enter a Title";
                          } else {
                            return null;
                          }
                        },
                        controller: _noteSectionNameContraller,
                        label: "Note Section Name",
                        keyboardType: TextInputType.text,
                      ),
                      //SizedBox(height: 10),
                      CustomTextField(
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return " Enter a Title";
                          } else {
                            return null;
                          }
                        },
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
                  onPressed: _pickImage,
                ),
                SizedBox(height: 10),
                _selectedImage != null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Selected Image"),
                          SizedBox(height: 10),
                          ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(10),
                            child: Image.file(
                              File(_selectedImage!.path),
                              width: double.infinity,
                              //height: 100,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Text(
                          "No Selected image",
                          style: Styles.bodyText,
                        ),
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
