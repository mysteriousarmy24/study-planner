import 'package:flutter/material.dart';
import 'package:study_planner/consts/colors.dart';

/// Shared application styles for text, cards, buttons and inputs.
///
/// Use `Styles` to keep styling consistent across the home, courses,
/// assignments, and other pages.
class Styles {
  Styles._();

  // Text styles
  static const TextStyle appTitle = TextStyle(
    color: Colors.white,
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
  );

  static const TextStyle pageHeading = TextStyle(
    color: Colors.white,
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle sectionTitle = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle sectionSubtitle = TextStyle(
    color: Color(0xFFB0B6C1),
    fontSize: 14,
    height: 1.4,
  );

  static const TextStyle cardTitle = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle cardSubtitle = TextStyle(
    color: Color(0xFFB0B6C1),
    fontSize: 13,
    height: 1.4,
  );

  static const TextStyle bodyText = TextStyle(
    color: Colors.white70,
    fontSize: 14,
    height: 1.5,
  );

  static const TextStyle noteText = TextStyle(
    color: Colors.white70,
    fontSize: 13,
  );

  static const TextStyle buttonText = TextStyle(
    color: Colors.white,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle inputLabel = TextStyle(
    color: Colors.white70,
    fontSize: 13,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle inputHint = TextStyle(
    color: Color(0xFF8C98A4),
    fontSize: 13,
  );

  static const TextStyle hintErrorText = TextStyle(
    color: Colors.redAccent,
    fontSize: 12,
  );

  // Decorations
  static final BoxDecoration cardDecoration = BoxDecoration(
    color: const Color(0xFF1F262F),
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: 0.25),
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
    ],
  );

  static final BoxDecoration sectionCardDecoration = BoxDecoration(
    color: const Color(0xFF212A33),
    borderRadius: BorderRadius.circular(18),
    border: Border.all(color: Colors.white12),
  );

  static final BoxDecoration elevatedButtonDecoration = BoxDecoration(
    color: primaryColor,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: primaryColor.withValues(alpha: 0.35),
        blurRadius: 12,
        offset: const Offset(0, 6),
      ),
    ],
  );

  static final BoxDecoration inputFieldDecoration = BoxDecoration(
    color: const Color(0xFF151A20),
    borderRadius: BorderRadius.circular(14),
    border: Border.all(color: Colors.white12),
  );

  // Input field decoration helper.
  static InputDecoration inputDecoration({
    required String hintText,
    String? labelText,
  }) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFF151A20),
      labelText: labelText,
      labelStyle: inputLabel,
      hintText: hintText,
      hintStyle: inputHint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.white12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: primaryColor, width: 1.5),
      ),
    );
  }

  // Common spacing values used across screens.
  static const EdgeInsets screenPadding = EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 18,
  );
  static const EdgeInsets cardContentPadding = EdgeInsets.all(18);
  static const EdgeInsets sectionSpacing = EdgeInsets.only(top: 18);
}
