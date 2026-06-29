// Flutter UI framework
import 'package:flutter/material.dart';
// `intl` provides utilities for formatting dates/times
import 'package:intl/intl.dart';
// Project-wide color constants (see lib/consts/colors.dart)
import 'package:study_planner/consts/colors.dart';
// Notification model class that represents a notification document
import 'package:study_planner/models/Notification_model.dart';
// Assignment model — may be used by notification logic elsewhere
import 'package:study_planner/models/assignment_model.dart';
// Service layer that fetches notifications from the database (Firebase/Firestore)
import 'package:study_planner/services/database/notification_services.dart';

// A simple page that displays notifications fetched from the database.
// Important: `NotificationServices().getNotifications()` is where the
// database interaction happens (likely using Firebase/Firestore under the hood).
// If you're new to Firebase, open `lib/services/database/notification_services.dart`
// to see how documents are queried and mapped into `NotificationModel`.
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  // Helper that calls the service layer to get notifications.
  // This returns a `Future<List<NotificationModel>>` which we consume
  // with a `FutureBuilder` in `build()` below. Keep this async so
  // any network/database latency doesn't block the UI thread.
  Future<List<NotificationModel>> _fetchNotifications() async {
    return await NotificationServices().getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        // The future that fetches notifications. FutureBuilder listens
        // to the Future and rebuilds the UI when it completes.
        future: _fetchNotifications(),
        builder: (context, snapshot) {
          // Common FutureBuilder states:
          // - ConnectionState.waiting: still loading — show a spinner
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
            // - snapshot.hasError: the Future threw an exception — show error
          } else if (snapshot.hasError) {
            // In development you might print the full error or send it to
            // a logging service. Here we show a simple error message.
            return Center(child: Text('Error: ${snapshot.error}'));
            // - empty data: the query returned no notifications
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No notifications available.'));
          }

          // When data is available, show a scrollable list of notifications.
          final notifications = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];

              // Each notification is shown as a ListTile with a colored
              // subtitle container. `primaryColor` comes from
              // `lib/consts/colors.dart` and is used for consistent theming.
              return ListTile(
                // Title: assignment name from the NotificationModel
                title: Text(
                  notification.assignmentName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Container(
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Course name — simple string interpolation
                        Text(
                          'Course: ${notification.courseName}',
                          style: const TextStyle(color: Colors.black),
                        ),
                        // Assignment name again (keeps details visible)
                        Text(
                          'Assignment: ${notification.assignmentName}',
                          style: const TextStyle(color: Colors.black),
                        ),
                        // Format the due date in a human-friendly way using intl
                        Text(
                          'Due Date: ${DateFormat.yMMMd().format(notification.dueDate)}',
                          style: const TextStyle(color: Colors.black),
                        ),
                        // Calculate remaining time until due date in hours.
                        // `difference` returns a Duration: positive if due date
                        // is in the future, negative if it's already past.
                        Text(
                          'Time: ${(notification.dueDate.difference(DateTime.now()).inHours).toString()} hours',
                          style: const TextStyle(color: Colors.black),
                        ),
                        // NOTE: If you need more friendly output like "2 days"
                        // or "3 hours left", convert Duration to days/hours/mins
                        // and handle negative values (overdue) accordingly.
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
