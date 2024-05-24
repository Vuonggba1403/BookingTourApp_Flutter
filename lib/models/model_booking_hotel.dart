import 'package:cloud_firestore/cloud_firestore.dart';

class BookingHotel {
  final String name_hotel;
  final int num_of_peo;
  final String time;
  final int totalDays;
  final int totalPrice;
  final String first_name;
  final String last_name;
  final String email;
  final String phone;

  BookingHotel({
    required this.name_hotel,
    required this.num_of_peo,
    required this.time,
    required this.totalDays,
    required this.totalPrice,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.phone,
  });

  factory BookingHotel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return BookingHotel(
      name_hotel: data['name_hotel'] ?? '',
      num_of_peo: ((data['number_of_peopele'] ?? 0) as num).toInt(),
      time: data['time'] ?? '',
      totalDays: ((data['totalDays'] ?? 0) as num).toInt(),
      totalPrice: ((data['totalPrice'] ?? 0) as num).toInt(),
      first_name: data['firstName'] ?? '',
      last_name: data['lastName'] ?? '',
      email: data['email'] ?? '',
      phone: data['phoneNumber'] ?? '',
    );
  }
}
