import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite {
  final String img;
  final String name;
  final String price;
  final String des;
  final String docId;

  Favorite(
      {required this.img,
      required this.name,
      required this.docId,
      required this.des,
      required this.price});

  factory Favorite.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Favorite(
      docId: doc.id,
      price: data['price'] ?? '',
      des: data['description'] ?? '',
      name: data['name'] ?? '',
      img: data['img'] ?? '',
    );
  }
}
