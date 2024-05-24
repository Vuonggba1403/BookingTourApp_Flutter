import 'package:BookingTourApp/Screens/details_screen/detail_travel.dart';
import 'package:BookingTourApp/Screens/details_screen/detail_stays.dart';
import 'package:BookingTourApp/Themes/Colors.dart';
import 'package:BookingTourApp/data/Custom/loading_screen.dart';
import 'package:BookingTourApp/models/models_hotel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:intl/intl.dart";

class ViewStaysCard extends StatelessWidget {
  final List listOfStays;
  final bool isSorted;
  const ViewStaysCard(
      {super.key, required this.listOfStays, required this.isSorted});

  String formatPrice(price) {
    final f = NumberFormat("###,###.###", "tr_TR");
    return f.format(price);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('hotel').snapshots(),
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

          var stays = snapshot.data?.docs;

          if (listOfStays.isNotEmpty) {
            stays = snapshot.data?.docs
                .where((element) => listOfStays.contains(element.id))
                .toList();
          }

          if (isSorted) {
            stays?.shuffle();
          }

          final hotelList =
              stays?.map((doc) => Hotel.fromFirestore(doc)).toList() ?? [];

          return Column(
            children: hotelList.map((hotel) {
              // caculator new price
              String newprice =
                  (double.parse(hotel.oldprice.replaceAll('.', '')) -
                          (double.parse(hotel.oldprice.replaceAll('.', '')) /
                              100 *
                              double.parse(hotel.percent)))
                      .toStringAsFixed(0)
                      .replaceAllMapped(
                        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match match) => '${match[1]}.',
                      );
              // String newprice =
              //     (double.parse(hotel.oldprice.replaceAll('.', '')) -
              //             (double.parse(hotel.oldprice.replaceAll('.', '')) /
              //                 100 *
              //                 double.parse(hotel.percent)))
              //         .toStringAsFixed(0);
              // int newprice =
              //     (hotel.oldprice - (hotel.oldprice / hotel.percent)).round();

              return GestureDetector(
                onTap: () {
                  loadingScreen(
                      context,
                      () => ViewDetailStays(
                            hotel: hotel,
                            newprice: newprice,
                          ));
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: SizedBox(
                              width: double.infinity,
                              height: 280,
                              child: Image.network(
                                hotel.img,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 7,
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                margin: const EdgeInsets.only(bottom: 20.2),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //percent
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 50,
                                          // color: Colors.yellow,
                                          decoration: const BoxDecoration(
                                              color: Colors.yellow,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10))),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              const FaIcon(
                                                FontAwesomeIcons.bolt,
                                                color: Colors.red,
                                                size: 18,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '${hotel.percent.toString()}%',
                                                style: const TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 13,
                                                    fontFamily: "OpenSans",
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),

                                    // name
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 8,
                                          child: SizedBox(
                                            width: double.infinity,
                                            child: Text(
                                              hotel.name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    // rating
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: int.parse(hotel.rate
                                                          .replaceAll(
                                                              '.', '')) >=
                                                      80
                                                  // hotel.rate >= 80
                                                  ? primaryColor
                                                  : Colors.red,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(8)),
                                            ),
                                            child: Text(
                                              hotel.rate.toString(),
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255)),
                                            )),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          int.parse(hotel.rate
                                                      .replaceAll('.', '')) >
                                                  80
                                              ? "Tuyệt hảo"
                                              : "Tốt",

                                          // hotel.rate > 80 ? "Tuyệt hảo" : "Tốt",
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          '87 đánh giá',
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromARGB(
                                                  255, 123, 123, 123)),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),

                                    // description
                                    Text(
                                      hotel.des,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // price
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //old price
                                        Text("VND ${hotel.oldprice}",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.red,
                                                decoration: TextDecoration
                                                    .lineThrough)),

                                        //new price
                                        Text(
                                          "$newprice VND",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // free cancel
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Icon(
                                          int.parse(hotel.rate
                                                      .replaceAll('.', '')) >
                                                  80
                                              ? Icons.check
                                              : null,
                                          // hotel.rate >= 80 ? Icons.check : null,
                                          size: 20,
                                          color: const Color.fromARGB(
                                              255, 78, 203, 113),
                                        ),
                                        Text(
                                          int.parse(hotel.rate
                                                      .replaceAll('.', '')) >
                                                  80
                                              // hotel.rate >= 80
                                              ? "Có lựa chọn huỷ miễn phí"
                                              : "Ưu đãi và giảm giá",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: int.parse(hotel.rate
                                                          .replaceAll(
                                                              '.', '')) >
                                                      80
                                                  // hotel.rate >= 80
                                                  ? const Color.fromARGB(
                                                      255, 78, 203, 113)
                                                  : Colors.red),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),

                                    // placed
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        hotel.placed,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    )
                  ],
                ),
              );
            }).toList(),
          );
        });
  }
}
