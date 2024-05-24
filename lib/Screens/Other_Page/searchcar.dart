import 'package:BookingTourApp/Screens/details_screen/details_car.dart';
import 'package:BookingTourApp/Themes/Colors.dart';
import 'package:BookingTourApp/data/car_list.dart';
import 'package:BookingTourApp/models/models_rentalcar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchCarScreen extends StatelessWidget {
  const SearchCarScreen({super.key});

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
          'Tìm kiếm xe',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
      ),
      body: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('rentalcar').snapshots(),
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

            final rentalcarList = snapshot.data?.docs
                    .map((doc) => RentalCar.fromFirestore(doc))
                    .toList() ??
                [];
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: rentalcarList.map((rentalcar) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CarDetailScreen(rentalcar)));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Stack(
                              children: [
                                Container(
                                  width: double.maxFinite,
                                  margin: const EdgeInsets.only(
                                      left: 24, right: 24, top: 50),
                                  padding: const EdgeInsets.only(
                                      left: 25, bottom: 15, right: 20, top: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(colors: [
                                      secondaryColor,
                                      primaryColor,
                                      backgroundColor2
                                    ]),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${rentalcar.price} VND",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Text(
                                        "Giá/h",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CarItems(
                                              name: "Hãng xe",
                                              value: rentalcar.type),
                                          CarItems(
                                              name: "Biển số xe",
                                              value: rentalcar.license_plate),
                                          CarItems(
                                              name: "Loại xe",
                                              value: rentalcar.seat),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                  right: 30,
                                  child: Hero(
                                    tag: rentalcar.img,
                                    child: Image.network(
                                      rentalcar.img,
                                      height: 90,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
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
