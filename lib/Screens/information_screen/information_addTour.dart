import 'package:BookingTourApp/Screens/details_screen/details_car.dart';
import 'package:BookingTourApp/Themes/Colors.dart';
import 'package:BookingTourApp/data/Custom/custom_text.dart';
import 'package:BookingTourApp/models/model_addAttraction.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InformationBuyTicket extends StatefulWidget {
  const InformationBuyTicket({super.key});

  @override
  State<InformationBuyTicket> createState() => _InformationBuyTicketState();
}

class _InformationBuyTicketState extends State<InformationBuyTicket> {
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
          'Lịch sử mua tour',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('addBookingAttraction')
              .snapshots(),
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

            final buyTourlList = snapshot.data?.docs
                    .map((doc) => addAttraction.fromFirestore(doc))
                    .toList() ??
                [];
            if (buyTourlList.isEmpty) {
              return const Center(
                child: Text(
                  'Chưa có lịch sử đặt tour nào!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            return MasonryGridView.builder(
              itemCount: buyTourlList.length,
              gridDelegate:
                  const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                final buyTourList = buyTourlList[index];
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 190 + (index % 3) * 50.0,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                                child: CustomText(
                                    text: "Tour: ${buyTourList.placed}")),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Text('IVIVU',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold)),
                                  Text('.COM',
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            CustomText(
                                text: "Giá vé: ${buyTourList.price_ticket}"),
                            CustomText(
                                text:
                                    "Loại xe thuê : ${buyTourList.car} - Giờ thuê: ${buyTourList.hour}"),
                            CustomText(
                                text: "Tổng tiền: ${buyTourList.price} VND"),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
    );
  }
}
