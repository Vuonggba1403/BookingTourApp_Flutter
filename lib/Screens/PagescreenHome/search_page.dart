import 'package:BookingTourApp/Screens/Other_Page/attractions/view_attractions.dart';
import 'package:BookingTourApp/Screens/Other_Page/favorite.dart';
import 'package:BookingTourApp/Screens/details_screen/detail_travel.dart';
import 'package:BookingTourApp/Screens/Other_Page/help.dart';
import 'package:BookingTourApp/Screens/Other_Page/searchcar.dart';
import 'package:BookingTourApp/Themes/Colors.dart';
import 'package:BookingTourApp/components/attractions/search_bar_attractions.dart';
import 'package:BookingTourApp/components/stays/search_bar_stays.dart';
import 'package:BookingTourApp/data/Custom/loading_screen.dart';
import 'package:BookingTourApp/data/travel_list.dart';
import 'package:BookingTourApp/models/model_favorite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _HomePageState();
}

class _HomePageState extends State<SearchPage> {
  String input = '';
  String selectedDate = '';
  int indexOfSelected = 0;
  bool showSearchStaysBar = true;

  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      Icons.bed_sharp,
      Icons.car_rental,
      FontAwesomeIcons.heart,
      Icons.attractions_outlined
    ];

    List<String> features = [
      "Lưu trú",
      "Thuê xe",
      "Đã thích",
      "Địa điểm tham quan"
    ];

    void updateUI(index) {
      switch (index) {
        // rental car
        case 1:
          loadingScreen(context, () => const SearchCarScreen());
          break;

        // favorite
        case 2:
          loadingScreen(context, () => FavoriteScreen());
          break;

        // Stays and attractions
        case 3:
          loadingScreen(context, () => const ViewAttractions());
          break;
        default:
          {
            if (index == 0) {
              setState(() {
                showSearchStaysBar = true;
              });
            } else {
              setState(() {
                showSearchStaysBar = false;
              });
            }
          }
      }
    }

    return Column(
      children: [
        // main function bar
        Container(
          width: double.infinity,
          height: 60,
          color: const Color.fromARGB(255, 0, 59, 149),
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      indexOfSelected = index;
                    });
                    updateUI(index);
                  },
                  child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: index == indexOfSelected
                                ? Colors.white
                                : Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(25)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            icons[index],
                            size: 23,
                            color: Colors.white,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            features[index],
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                        ],
                      )),
                );
              }),
        ),

        // body
        Expanded(
          flex: 1,
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(20),
            child: ListView(
              shrinkWrap: true,
              children: [
                // search bar
                SizedBox(
                  height: showSearchStaysBar ? 220 : 158,
                  child: showSearchStaysBar
                      ? const SearchBarStays()
                      : const SearchBarAttractions(),
                ),

                const SizedBox(
                  height: 20,
                ),

                //travel more, spen less
                const Text(
                  "Đi nhiều hơn, chi ít hơn",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),

                const SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 200,
                  width: 400,
                  child: ListView.builder(
                      itemCount: listTravel.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        final travelmodel = listTravel[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailTravelScreen(travelmodel),
                                ));
                          },
                          child: AspectRatio(
                              aspectRatio: 6 / 6,
                              child: Hero(
                                tag: travelmodel.Image,
                                child: Container(
                                  margin: const EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        width: 2, color: Colors.grey),
                                    image: DecorationImage(
                                        image: AssetImage(travelmodel.Image),
                                        fit: BoxFit.cover),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            travelmodel.nameTravel,
                                            softWrap: true,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 10),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const FaIcon(
                                                FontAwesomeIcons.gratipay,
                                                color: Colors.red,
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                travelmodel.titleTravel,
                                                softWrap: true,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )),
                        );
                      }),
                ),

                const SizedBox(
                  height: 20,
                ),

                //cau hoi thuong gap
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HelpScreen(),
                        ));
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 3,
                            color: Colors.grey,
                            spreadRadius: 2,
                          )
                        ],
                        color: secondaryColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          child: Container(
                            height: double.maxFinite,
                            width: 100,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  topRight: Radius.circular(40),
                                  bottomRight: Radius.circular(5)),
                              color: Colors.yellow,
                            ),
                            child: const Center(
                              child: FaIcon(
                                FontAwesomeIcons.circleQuestion,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const Row(
                          children: [
                            Text(
                              "Giải đáp các ",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: "OpenSans"),
                            ),
                            Text(
                              "câu hỏi thường gặp ",
                              style: TextStyle(
                                fontFamily: "OpenSans",
                                color: Color.fromARGB(255, 225, 218, 12),
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                        const FaIcon(
                          FontAwesomeIcons.arrowRight,
                          color: Color.fromARGB(255, 225, 218, 12),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Yêu thích",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('favorites')
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

                      final favoritesList = snapshot.data?.docs
                              .map((doc) => Favorite.fromFirestore(doc))
                              .toList() ??
                          [];

                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: favoritesList.map((favorite) {
                            return Row(children: [
                              Container(
                                width: 170,
                                height: 170,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2, color: Colors.black),
                                    image: DecorationImage(
                                        image: NetworkImage(favorite.img),
                                        fit: BoxFit.cover)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.maxFinite,
                                      color: Colors.black.withOpacity(0.5),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4,
                                        horizontal: 8,
                                      ),
                                      child: Center(
                                        child: Text(
                                          favorite.name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      color: Colors.black.withOpacity(0.5),
                                      child: Text("${favorite.price} VND",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              )
                            ]);
                          }).toList(),
                        ),
                      );
                    }),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
