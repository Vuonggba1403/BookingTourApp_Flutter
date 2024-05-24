import 'package:BookingTourApp/Screens/details_screen/details_attractions.dart';
import 'package:BookingTourApp/data/Custom/loading_screen.dart';
import 'package:BookingTourApp/data/Custom/showCustomDelightToastBar.dart';
import 'package:BookingTourApp/models/models_placed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewAttractionCard extends StatefulWidget {
  final bool sortAndFilter;
  const ViewAttractionCard({super.key, required this.sortAndFilter});

  @override
  State<ViewAttractionCard> createState() => _ViewAttractionCardState();
}

class _ViewAttractionCardState extends State<ViewAttractionCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Placed').snapshots(),
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

          var attractions = snapshot.data?.docs;

          if (widget.sortAndFilter) {
            attractions?.shuffle();
          }

          final placedList =
              attractions?.map((doc) => Placed.fromFirestore(doc)).toList() ??
                  [];
          return Column(
            children: placedList.map((placed) {
              return GestureDetector(
                onTap: () {
                  loadingScreen(
                      context,
                      () => DetailAttractionScreen(
                            placed: placed,
                          ));
                },
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: GestureDetector(
                        child: Container(
                          width: double.maxFinite,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey[200],
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                )
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: Image.network(placed.img).image,
                                        fit: BoxFit.cover),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8))),
                                width: MediaQuery.of(context).size.width * 0.35,
                                height: double.maxFinite,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            placed.placed,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Color.fromARGB(
                                                  255, 78, 78, 78),
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Expanded(
                                        child: Text(
                                          placed.des,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "OpenSans",
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          FaIcon(
                                            int.parse(placed.money
                                                        .replaceAll('.', '')) >=
                                                    1000000
                                                ? FontAwesomeIcons.check
                                                : FontAwesomeIcons.ccVisa,
                                            color: int.parse(placed.money
                                                        .replaceAll('.', '')) >=
                                                    1000000
                                                ? Colors.green
                                                : Colors.red,
                                            size: 10,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            int.parse(placed.money
                                                        .replaceAll('.', '')) >=
                                                    1000000
                                                ? "Có lựa chọn huỷ miễn phí"
                                                : "Ưu đãi và giảm giá",
                                            style: TextStyle(
                                                color: int.parse(placed.money
                                                            .replaceAll(
                                                                '.', '')) >=
                                                        1000000
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            placed.money,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Text(
                                            "VND",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              );
            }).toList(),
          );
        });
  }
}
