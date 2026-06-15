class AssignmentModel {
  final String name;
  final String description;
  final int duration;
  final String date;
  final String time;

  AssignmentModel({
    required this.name,
    required this.description,
    required this.duration,
    required this.date,
    required this.time,
  });
  //to Json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'duration': duration,
      'date': date,
      'time': time,
    };
  }

  //from json
  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      duration: json['duration'] ?? 0,
      date: json['date'] ?? '',
      time: json['time'] ?? '',
    );
  }
}
