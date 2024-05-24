import 'package:cloud_firestore/cloud_firestore.dart';

class addAttraction {
  final String price_ticket;
  final int price;
  final String time;
  final String placed;
  final String? car;
  final int? hour;

  addAttraction({
    required this.price_ticket,
    required this.price,
    required this.time,
    required this.placed,
    required this.car,
    required this.hour,
  });

  factory addAttraction.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return addAttraction(
      price_ticket: data['priceticket'] ?? '',
      time: data['time'] ?? '',
      placed: data['placed'] ?? '',
      hour: ((data['hour'] ?? 0) as num).toInt(),
      price: ((data['price'] ?? 0) as num).toInt(),
      car: data['car'] ?? '',
    );
  }
}
