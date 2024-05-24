import 'package:BookingTourApp/Screens/GeminiChat/screens/GeminiChat.dart';
import 'package:BookingTourApp/Screens/PagescreenHome/news.dart';
import 'package:BookingTourApp/Screens/PagescreenHome/search_page.dart';
import 'package:BookingTourApp/Screens/PagescreenHome/discount_screen.dart';
import 'package:BookingTourApp/Screens/Other_Page/notification.dart';
import 'package:BookingTourApp/Screens/PagescreenHome/profile_page.dart';
import 'package:BookingTourApp/Themes/Colors.dart';
import 'package:BookingTourApp/components/stays/test.dart';
import 'package:BookingTourApp/data/Custom/loading_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';

class CurveBar extends StatefulWidget {
  const CurveBar({super.key});

  @override
  State<CurveBar> createState() => _CurveBarState();
}

class _CurveBarState extends State<CurveBar> {
  final items = [
    const FaIcon(
      FontAwesomeIcons.search,
      size: 25,
    ),
    const Icon(
      Icons.discount_outlined,
      size: 25,
    ),
    const FaIcon(
      FontAwesomeIcons.newspaper,
      size: 25,
    ),
    const FaIcon(
      FontAwesomeIcons.users,
      size: 25,
    ),
  ];
  int index = 0;
  final screen = [
    const SearchPage(),
    const DiscountPage(),
    const NewsPage(),
    const ProfileScreen(),
  ];

  bool isMessageOpen = false;

  // get screen => null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backroundColor3,
      //Title
      body: NestedScrollView(
          headerSliverBuilder: (context, innerIsScrolled) => [
                SliverAppBar(
                    floating: true,
                    snap: true,
                    automaticallyImplyLeading: false, //tat nut quay lai
                    backgroundColor: primaryColor,
                    title: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AnimatedTextKit(
                                animatedTexts: [
                                  WavyAnimatedText('iVIVU.COM',
                                      textStyle: const TextStyle(
                                          color: backroundColor3,
                                          fontSize: 30,
                                          fontFamily: 'Workbench',
                                          wordSpacing: 40,
                                          fontWeight: FontWeight.bold)),
                                ],
                                repeatForever: true,
                                isRepeatingAnimation: true,
                              ),
                              // icon notification
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const NotificationScreen(),
                                      ));
                                },
                                child: const badges.Badge(
                                  badgeStyle: badges.BadgeStyle(
                                    badgeColor: Colors.transparent,
                                  ),
                                  badgeContent: Icon(
                                    Icons.notifications_rounded,
                                    color: backroundColor3,
                                    size: 30,
                                  ),
                                  badgeAnimation:
                                      badges.BadgeAnimation.rotation(
                                    animationDuration: Duration(
                                        seconds: 1), //do dai hieu ung 1s
                                    curve: Curves.easeInOut,
                                    loopAnimation: false,
                                    colorChangeAnimationCurve:
                                        Curves.easeInCubic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
          //body screen
          body: screen[index]),
      floatingActionButton: FloatingActionButton(
        tooltip: "Trò Chuyện Với Gemini",
        elevation: 10,
        onPressed: () {
          loadingScreen(context, () => const GeminiChat());
        },
        hoverColor: Colors.blue,
        shape: const CircleBorder(),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 5)],
              image: const DecorationImage(
                  image: AssetImage("assets/gemini.png"))),
        ),
      ),

      //NavigationBar
      bottomNavigationBar: CurvedNavigationBar(
        color: const Color.fromARGB(31, 4, 9, 82),
        buttonBackgroundColor: Colors.blue,
        height: 60,
        animationCurve: Curves.decelerate,
        backgroundColor: Colors.transparent,
        items: items,
        index: index,
        onTap: (index) => setState(() {
          this.index = index;
        }),
      ),
    );
  }
}

// // o tin nhan
