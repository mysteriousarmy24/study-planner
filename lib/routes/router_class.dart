import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner/Pages/add_new_course.dart';
import 'package:study_planner/Pages/home_page.dart';

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
    ],
  );
}
