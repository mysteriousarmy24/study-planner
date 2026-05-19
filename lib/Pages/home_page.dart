import 'package:flutter/material.dart';
import 'package:study_planner/Pages/Navigation_bar_screens/assignments_screen.dart';
import 'package:study_planner/Pages/Navigation_bar_screens/courses_screen.dart';
import 'package:study_planner/Pages/Navigation_bar_screens/home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const List<Widget> _pages = [
    HomeScreen(),
    CoursesScreen(),
    AssignmentsScreen(),
  ];
  void _onClicked(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onClicked,
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.blueGrey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Courses'),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Assignments',
          ),
        ],
      ),
    );
  }
}
