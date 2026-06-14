class Courses {
  final String id;
  final String name;
  final String description;
  final int duration;
  final DateTime schedule;
  final String instructor;

  Courses({
    required this.id,
    required this.name,
    required this.description,
    required this.duration,
    required this.schedule,
    required this.instructor,
  });

  //to json
 factory Courses.fromJson(Map<String, dynamic> json) {
    return Courses(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      duration: json['duration'] ?? 0,
      schedule: DateTime.parse(json['schedule'] ?? DateTime.now().toIso8601String()),
      instructor: json['instructor'] ?? '',
    );
  }

  //to map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'duration': duration,
      'schedule': schedule.toIso8601String(),
      'instructor': instructor,
    };
  }
}
