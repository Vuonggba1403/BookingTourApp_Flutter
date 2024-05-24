import 'package:BookingTourApp/Screens/details_screen/details_car.dart';
import 'package:BookingTourApp/Themes/Colors.dart';
import 'package:BookingTourApp/models/model_booking_hotel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.white,
            )),
        title: const Text(
          'Lịch sử',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('BookingHotel').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: SpinKitDancingSquare(
                  color: Colors.black,
                  duration: Duration(seconds: 2),
                  size: 45.0,
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final bookHotelList = snapshot.data?.docs
                    .map((doc) => BookingHotel.fromFirestore(doc))
                    .toList() ??
                [];
            if (bookHotelList.isEmpty) {
              return const Center(
                child: Text(
                  'Chưa có lịch sử đặt phòng nào!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: bookHotelList.map((booking_hotel) {
                    return Column(
                      children: [
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.25,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey[300],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Center(
                                  child: Text(
                                    "KS : ${booking_hotel.name_hotel}",
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            'Số người: ${booking_hotel.num_of_peo}'),
                                        Text(
                                            'Tổng số ngày: ${booking_hotel.totalDays}'),
                                        Text(
                                            'Tổng giá: ${booking_hotel.totalPrice.toStringAsFixed(0).replaceAllMapped(
                                                  RegExp(
                                                      r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                  (Match match) =>
                                                      '${match[1]}.',
                                                )} VND'),
                                      ],
                                    ),
                                    Container(
                                      width: 1,
                                      height: double.maxFinite,
                                      color: Colors.black,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Text(
                                              'Tên : ${booking_hotel.first_name} ${booking_hotel.last_name}'),
                                        ),
                                        Expanded(
                                            child: Text(
                                                'Email: ${booking_hotel.email}')),
                                        Expanded(
                                            child: Text(
                                                'SDT: ${booking_hotel.phone}')),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        children: [
                                          Text(
                                            "IVIVU",
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            ".COM",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                      Text(
                                        'Thời gian: ${booking_hotel.time}',
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          }),
    );
  }
}
