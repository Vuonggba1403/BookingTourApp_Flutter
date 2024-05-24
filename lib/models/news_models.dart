import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  final String title;
  final String description;
  final String imageUrl;

  News(
      {required this.title, required this.description, required this.imageUrl});

  factory News.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return News(
      title: data['Title'] ?? '',
      description: data['Desciption'] ?? '',
      imageUrl: data['Images'] ?? '',
    );
  }
}
