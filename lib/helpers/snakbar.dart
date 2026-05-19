import 'package:flutter/material.dart';

void showSnackBar({required String massege, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(massege), duration: Duration(seconds: 2)),
  );
}
