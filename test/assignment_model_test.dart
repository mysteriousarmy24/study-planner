import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_planner/models/assignment_model.dart';

void main() {
  group('AssignmentModel.fromJson', () {
    test(
      'uses the Firestore document id when the payload has no explicit id',
      () {
        final assignment = AssignmentModel.fromJson({
          'name': 'Test assignment',
          'description': 'Need to be notified',
          'duration': 2,
          'date': Timestamp.fromDate(DateTime(2026, 6, 29, 10)),
          'time': '10:00',
        }, 'doc-123');

        expect(assignment.id, 'doc-123');
      },
    );
  });
}
