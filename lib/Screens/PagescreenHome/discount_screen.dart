import 'package:BookingTourApp/Themes/Colors.dart';
import 'package:BookingTourApp/data/Custom/loading_screen.dart';
import 'package:BookingTourApp/data/Custom/showCustomDelightToastBar.dart';
import 'package:BookingTourApp/models/models_discount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DiscountPage extends StatelessWidget {
  const DiscountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Discount').snapshots(),
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

            final discountList = snapshot.data?.docs
                    .map((doc) => Discount.fromFirestore(doc))
                    .toList() ??
                [];
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: discountList.map((discount) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            discount.status == "OLD CODE"
                                ? showCustomDelightToastBar(
                                    context, "Mã giảm giá đã hết hạn")
                                : null;
                          },
                          child: Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.22,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[300],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: discount.status == "OLD CODE"
                                          ? const Color.fromARGB(
                                              255, 243, 91, 80)
                                          : Colors.green,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          bottomLeft: Radius.circular(8))),
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  height: double.maxFinite,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                              width: 60,
                                              height: 30,
                                              decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10)),
                                                  color: Colors.white),
                                              child: Center(
                                                  child: Text(
                                                discount.dis_name,
                                                style: TextStyle(
                                                  decorationThickness: 3,
                                                  decorationColor: Colors.black,
                                                  decoration: discount.status ==
                                                          "OLD CODE"
                                                      ? TextDecoration
                                                          .lineThrough
                                                      : TextDecoration.none,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                              ))),
                                        ],
                                      ),
                                      Text(
                                        "${discount.per}%",
                                        style: TextStyle(
                                          fontFamily: "OpenSans",
                                          decorationThickness: 4,
                                          decorationColor: Colors.white,
                                          decoration:
                                              discount.status == "OLD CODE"
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Container(
                                            width: double.maxFinite,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                                color: const Color.fromARGB(
                                                    255, 86, 84, 84)),
                                            child: Center(
                                                child: Text(
                                              discount.status,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ))),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            FaIcon(
                                              discount.status == "OLD CODE"
                                                  ? null
                                                  : FontAwesomeIcons
                                                      .checkCircle,
                                              color: Colors.green,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              discount.day,
                                              style: const TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            discount.des,
                                            softWrap: true,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 3,
                                            style: TextStyle(
                                              decorationThickness: 4,
                                              decoration: discount.status ==
                                                      "OLD CODE"
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                              fontSize: 13,
                                              fontFamily: "OpenSans",
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Kích hoạt counpon này ",
                                              style: TextStyle(
                                                  color: discount.status ==
                                                          "OLD CODE"
                                                      ? Colors.black
                                                      : primaryColor,
                                                  decorationThickness: 3,
                                                  decoration: discount.status ==
                                                          "OLD CODE"
                                                      ? TextDecoration
                                                          .lineThrough
                                                      : TextDecoration.none,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            FaIcon(
                                              FontAwesomeIcons.chevronRight,
                                              color:
                                                  discount.status == "OLD CODE"
                                                      ? Colors.black
                                                      : primaryColor,
                                              size: 10,
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            const FaIcon(
                                              FontAwesomeIcons.thumbsUp,
                                              color: primaryColor,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Transform(
                                              transform:
                                                  Matrix4.rotationX(3.14159)
                                                    ..rotateY(3.14159),
                                              alignment: Alignment.center,
                                              child: const FaIcon(
                                                FontAwesomeIcons.thumbsUp,
                                                color: Colors.grey,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                            height: 15), // Khoảng cách giữa các container
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
