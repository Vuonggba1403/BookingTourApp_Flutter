import 'package:cloud_firestore/cloud_firestore.dart';

class Hotel {
  final String des;
  final String rate;
  final String name;
  final String oldprice;
  final String img;
  final String placed;
  final String detail_placed;
  final String percent;
  final String id;

  Hotel(
      {required this.des,
      required this.rate,
      required this.name,
      required this.img,
      required this.percent,
      required this.id,
      required this.detail_placed,
      required this.placed,
      required this.oldprice});

  factory Hotel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Hotel(
      placed: data['placed'] ?? '',
      img: data['img'] ?? '',
      rate: data['rate'] ?? '',
      id: data['id'] ?? '',
      percent: data['percent'] ?? '',
      des: data['des'] ?? '',
      detail_placed: data['detail_placed'] ?? '',
      name: data['name'] ?? '',
      oldprice: data['oldprice'] ?? '',
    );
  }
}
