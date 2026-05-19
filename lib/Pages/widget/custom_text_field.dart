import 'package:flutter/material.dart';
import 'package:study_planner/Pages/consts/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String label;

  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: darkGreen),
            borderRadius: BorderRadius.circular(12.0),
          ),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 13.0,
            horizontal: 12.0,
          ),
        ),
      ),
    );
  }
}
