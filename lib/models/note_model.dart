import 'dart:io';

class Note {
  final String id;
  final File? imageData;
  final String? imageUrl;
  final String title;
  final String description;
  final String sectionName;
  final String referenceBooks;

  Note({
    required this.title,
    required this.description,
    required this.sectionName,
    required this.referenceBooks,
    required this.id,
    this.imageData,
    this.imageUrl,
  });
  //from json
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      title: json['title'] ?? ' ',
      description: json['description'] ?? ' ',
      sectionName: json['section-name'] ?? ' ',
      referenceBooks: json['reference-book'],
      imageUrl: json['imageUrl'],
      id: json['id'],
    );
  }
  //to json
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'section-name': sectionName,
      'reference-book': referenceBooks,
      'imageUrl': imageUrl,
      'id': id,
    };
  }
}
