import 'package:cloud_firestore/cloud_firestore.dart';

class Discount {
  final String status;
  final String des;
  final int per;
  final String day;
  final String dis_name;

  Discount(
      {required this.per,
      required this.status,
      required this.des,
      required this.dis_name,
      required this.day});

  factory Discount.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Discount(
      status: data['status'] ?? '',
      des: data['des'] ?? '',
      per: data['percent'] ?? '',
      day: data['day'] ?? '',
      dis_name: data['discount_name'] ?? '',
    );
  }
}
