import 'package:BookingTourApp/Screens/Other_Page/attractions/view_attractions.dart';
import 'package:BookingTourApp/Themes/Colors.dart';
import 'package:BookingTourApp/components/attractions/view_attractions_card.dart';
import 'package:BookingTourApp/data/Custom/loading_screen.dart';
import 'package:BookingTourApp/data/travel_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailTravelScreen extends StatelessWidget {
  const DetailTravelScreen(
    this.travelmodel, {
    super.key,
  });
  // ignore: non_constant_identifier_names
  final TravelList travelmodel;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; //tra ve kich thuoc man hinh
    return Scaffold(
      backgroundColor: primaryColor.withOpacity(0.5),
      body: Stack(
        children: [
          Container(
              height: size.height * 0.4,
              width: double.infinity,
              // child: Hero(
              //     tag: "travelmodel.Image",
              child: Hero(
                tag: travelmodel.Image,
                child: Image.asset(
                  travelmodel.Image,
                  fit: BoxFit.cover,
                ),
              )),
          // ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.white,
                  ),
                ),
                const FaIcon(
                  FontAwesomeIcons.bars,
                  color: Colors.white,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.6,
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(colors: [
                    secondaryColor,
                    primaryColor,
                    backgroundColor2
                  ])),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      travelmodel.nameTravel,
                      style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "OpenSans"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(travelmodel.description,
                        softWrap: true,
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w200)),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.image,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Một vài hình ảnh liên quan",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "OpenSans",
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Text(
                          "13/04/2024",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 10),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    // HINH ANH LIEN QUAN
                    SizedBox(
                      height: 100,
                      width: 400,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: travelmodel.descriptionImg.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 10), // Khoảng cách giữa các hình ảnh
                            child: Image.asset(
                              travelmodel.descriptionImg[index],
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                width: double.maxFinite,
                height: 50,
                decoration: BoxDecoration(
                    color: backroundColor3,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black, // do lech bong theo x,y
                          offset: Offset(5, 10), // ban kinh lam mo bong
                          blurRadius: 15,
                          spreadRadius: 2 //ban kinh phu bong xung quanh
                          )
                    ]),
                child: GestureDetector(
                  onTap: () =>
                      loadingScreen(context, () => const ViewAttractions()),
                  child: const Center(
                    child: Text(
                      "Cùng Nhau Trải Nghiệm",
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
