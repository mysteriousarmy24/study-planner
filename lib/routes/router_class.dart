import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner/Pages/add_new_assigenment.dart';

import 'package:study_planner/Pages/add_new_course.dart';
import 'package:study_planner/Pages/add_new_notes.dart';
import 'package:study_planner/Pages/home_page.dart';
import 'package:study_planner/Pages/single_course_page.dart';

import 'package:study_planner/models/courses_model.dart';

class RouterClass {
  final router = GoRouter(
    initialLocation: "/",
    errorPageBuilder: (context, state) {
      return MaterialPage(
        child: Scaffold(body: Center(child: Text("This page not avalable..."))),
      );
    },
    routes: [
      //homepage
      GoRoute(path: "/", name: "Home", builder: (context, state) => HomePage()),
      GoRoute(
        path: "/add-course",
        name: "AddCourse",
        builder: (context, state) => AddNewCourse(),
      ),
      GoRoute(
        path: "/single-course-page",
        name: "single course page",
        builder: (context, state) {
          final Courses course = state.extra as Courses;
          return SingleCoursePage(course: course);
        },
      ),
      GoRoute(
        path: "/new-assignment",
        name: "newAssignment",
        builder: (context, state) {
          final Courses course = state.extra as Courses;
          return AddNewAssigenment(course: course);
        },
      ),
      GoRoute(
        path: "/new-notes",
        name: "newNotes",
        builder: (context, state) {
          final Courses course = state.extra as Courses;
          return addNewNote(course: course);
        },
      ),
    ],
  );
}
