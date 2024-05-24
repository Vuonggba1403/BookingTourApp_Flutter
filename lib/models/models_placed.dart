import 'package:cloud_firestore/cloud_firestore.dart';

class Placed {
  final String img;
  final String des;
  final String placed;
  final String money;

  Placed(
      {required this.img,
      required this.placed,
      required this.des,
      required this.money});

  factory Placed.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Placed(
      img: data['img'] ?? '',
      des: data['des'] ?? '',
      placed: data['placed'] ?? '',
      money: data['money'] ?? '',
    );
  }
}
