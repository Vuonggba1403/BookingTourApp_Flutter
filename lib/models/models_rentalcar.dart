import 'package:cloud_firestore/cloud_firestore.dart';

class RentalCar {
  final String des;
  final String driver;
  final String img;
  final String license_plate;
  final String price;
  final String rate;
  final String seat;
  final String type;

  RentalCar({
    required this.img,
    required this.des,
    required this.driver,
    required this.license_plate,
    required this.price,
    required this.rate,
    required this.seat,
    required this.type,
  });

  factory RentalCar.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return RentalCar(
      img: data['img'] ?? '',
      des: data['des'] ?? '',
      driver: data['driver'] ?? '',
      license_plate: data['license_plate'] ?? '',
      price: data['price'] ?? '',
      rate: data['rate'] ?? '',
      seat: data['seat'] ?? '',
      type: data['type'] ?? '',
    );
  }
}
