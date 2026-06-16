import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:study_planner/consts/Styles.dart';
import 'package:study_planner/helpers/snakbar.dart';
import 'package:study_planner/models/courses_model.dart';
import 'package:study_planner/models/note_model.dart';
import 'package:study_planner/services/cloud_storage/storage.dart';
import 'package:study_planner/services/database/note_services.dart';
import 'package:study_planner/widget/custom_text_field.dart';
import 'package:study_planner/widget/cutom_button.dart';

class addNewNote extends StatefulWidget {
  final Courses course;
  const addNewNote({super.key, required this.course});

  @override
  State<addNewNote> createState() => _addNewNoteState();
}

class _addNewNoteState extends State<addNewNote> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();

  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _sectionController = TextEditingController();

  final TextEditingController _referenceController = TextEditingController();

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

  Future<void> _createNote() async {
    final Note note = Note(
      imageData: _selectedImage != null ? File(_selectedImage!.path) : null,
      title: _titleController.text,
      description: _descriptionController.text,
      sectionName: _sectionController.text,
      referenceBooks: _referenceController.text,
      id: ' ',
    );
    NoteServices().createNote(widget.course.id, note);
    print("Done..................");
    showSnackBar(massege: "Note Created..", context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Add new note", style: Styles.pageHeading),
                SizedBox(height: 20),
                Text(
                  "Fill in the details below to add a new note. And start managing your study planner.",
                ),
                SizedBox(height: 20),
                CustomTextField(
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter a Title";
                    } else {
                      return null;
                    }
                  },
                  controller: _titleController,
                  keyboardType: TextInputType.name,
                  label: "Note Title",
                ),
                SizedBox(height: 10),
                CustomTextField(
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter a Description";
                    } else {
                      return null;
                    }
                  },
                  controller: _descriptionController,
                  keyboardType: TextInputType.multiline,
                  label: "Note Description",
                ),
                SizedBox(height: 10),
                CustomTextField(
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter a Section Name";
                    } else {
                      return null;
                    }
                  },
                  controller: _sectionController,
                  keyboardType: TextInputType.name,
                  label: "Section Name",
                ),
                SizedBox(height: 10),
                CustomTextField(
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return "Enter a Reference Book";
                    } else {
                      return null;
                    }
                  },
                  controller: _referenceController,
                  keyboardType: TextInputType.name,
                  label: "Reference Books",
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
                Text(
                  "Upload Note Image , for better understanding and quick revision",
                  style: Styles.bodyText,
                ),
                SizedBox(height: 20),
                CustomElevatedButton(
                  onPressed: () {
                    _pickImage();
                  },
                  text: "Upload Note Image",
                ),
                SizedBox(height: 10),
                SizedBox(
                  child: _selectedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadiusGeometry.circular(15),
                          child: Image.file(
                            File(_selectedImage!.path),
                            width: double.infinity,
                          ),
                        )
                      : Text("No Image Selected", style: Styles.bodyText),
                ),
                SizedBox(height: 10),
                CustomElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _createNote();
                      GoRouter.of(context).pop();
                    }
                  },
                  text: "Submit Note",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
