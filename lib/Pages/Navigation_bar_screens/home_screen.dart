import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_planner/consts/Styles.dart';
import 'package:study_planner/consts/colors.dart';
import 'package:study_planner/services/database/courese_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text("Study Planner", style: Styles.appTitle),
                  Spacer(),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(primaryColor),
                    ),
                    onPressed: () {
                      //RouterClass().router.push("/add-course");
                      GoRouter.of(context).push("/add-course");
                    },
                    child: Row(
                      children: [
                        // Icon(Icons.add),
                        Text("+ add Course", style: Styles.buttonText),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Text(
                "Your study planner helps you to keep track of your study progress and manage your time effectively.",
                style: Styles.bodyText,
              ),
              SizedBox(height: 15),
              Text("Courses", style: Styles.pageHeading),
              Text("Your Running subjects", style: Styles.bodyText),
              SizedBox(height: 15),
              StreamBuilder(
                stream: CoureseServices().courses,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text("Error ${snapshot.error}");
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("asset/course.png", width: 400),
                          Text("No courses added yet", style: Styles.bodyText),
                        ],
                      ),
                    );
                  } else {
                    final courses = snapshot.data!;
                    return ListView.builder(
                      itemCount: courses.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final course = courses[index];
                        return GestureDetector(
                          onTap: () => GoRouter.of(
                            context,
                          ).push("/single-course-page", extra: course),
                          child: Card(
                            color: const Color.fromARGB(255, 16, 120, 190),
                            child: ListTile(
                              title: Text(course.name, style: Styles.cardTitle),
                              subtitle: Text(
                                course.description,
                                style: Styles.cardSubtitle,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
