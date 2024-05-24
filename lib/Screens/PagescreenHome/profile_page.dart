import 'dart:typed_data';
import 'dart:ui';
import 'package:BookingTourApp/Screens/Other_Page/change_language.dart';
import 'package:BookingTourApp/Screens/Other_Page/favorite.dart';
import 'package:BookingTourApp/Screens/information_screen/information_history.dart';
import 'package:BookingTourApp/Screens/information_screen/information_screen.dart';
import 'package:BookingTourApp/Screens/auth/Login.dart';
import 'package:BookingTourApp/Themes/Colors.dart';
import 'package:BookingTourApp/data/Custom/custom_container.dart';
import 'package:BookingTourApp/data/Custom/loading_screen.dart';
import 'package:BookingTourApp/data/Custom/showCustomDelightToastBar.dart';
import 'package:BookingTourApp/data/image_utils.dart';
import 'package:BookingTourApp/models/model_favorite.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? _image;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //change image
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

//save name
  Future<Map<String, dynamic>?> _getUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      return userDoc.data();
    }
    return null;
  }

  void _deleteAccount(BuildContext context) async {
    final user = _auth.currentUser;

    if (user != null) {
      try {
        // Delete user document from Firestore
        await _firestore.collection('users').doc(user.uid).delete();

        // Delete user from Firebase Authentication
        await user.delete();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.red[400],
              ),
              child: const Center(
                  child: Text(
                "Tài Khoản Của Bạn Đã Được Xoá Vĩnh Viễn",
                style: TextStyle(
                    color: Colors.black, fontFamily: "OpenSans", fontSize: 15),
              )),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
            duration: const Duration(seconds: 2),
          ),
        );
        loadingScreen(context, () => const LoginScreen());
      } catch (e) {
        // print("Xóa tài khoản thất bại: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.red[400],
              ),
              child: const Center(
                  child: Text(
                "Không thể xóa tài khoản của bạn. Vui lòng thử lại sau.",
                style: TextStyle(
                    color: Colors.black, fontFamily: "OpenSans", fontSize: 15),
              )),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              color: Colors.transparent,
              child: Stack(
                children: [
                  Container(
                    height: 230,
                    width: 200,
                    alignment: Alignment.topLeft,
                    decoration: const BoxDecoration(
                      color: Colors.lightGreenAccent,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(200),
                      ),
                    ),
                  ),
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      color: secondaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(200),
                      ),
                    ),
                  ),
                  Container(
                    height: 220,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(240),
                      ),
                    ),
                  ),
                  Positioned(
                      left: 50,
                      top: 70,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.yellow, width: 3)),
                        child: _image != null
                            ? CircleAvatar(
                                radius: 60,
                                backgroundImage: MemoryImage(_image!))
                            : const CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.white,
                                backgroundImage: AssetImage("assets/user.png")),
                      )),
                  Positioned(
                    left: 130,
                    top: 160,
                    child: GestureDetector(
                      onTap: () => {selectImage()},
                      child: const Icon(
                        Icons.add_a_photo,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  // check name user
                  Positioned(
                    left: 200,
                    top: 120,
                    child: FutureBuilder<Map<String, dynamic>?>(
                      future: _getUserData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SpinKitCubeGrid(
                            duration: Duration(milliseconds: 1200),
                            color: Colors.white,
                          );
                        } else {
                          final userData = snapshot.data!;
                          final userName = userData['name'] ?? "Tên người dùng";
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: "OpenSans",
                                ),
                              ),
                              GestureDetector(
                                onTap: () => showCustomDelightToastBar(
                                    context, "Chưa làm ! "),
                                child: const Row(
                                  children: [
                                    Text(
                                      "Thông tin cá nhân",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontFamily: "OpenSans",
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.chevronRight,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // change language
                GestureDetector(
                  onTap: () => showDialog(
                    builder: (context) => const Dialog(
                      child: ChangeLanguage(),
                    ),
                    barrierDismissible: false,
                    context: context,
                  ),
                  child: const UserInfoContainer(
                      iconData: Icons.language_outlined, text: "Ngôn Ngữ"),
                ),
                // delete account
                GestureDetector(
                  onTap: () => showDialog(
                    builder: (context) => AlertDialog(
                      shape: const RoundedRectangleBorder(),
                      titleTextStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      title: const Text(
                        "Bạn muốn xoá tài khoản vĩnh viễn, Sẽ không thể khôi phục lại tài khoản",
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    "Đóng",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontFamily: "OpenSans",
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    _deleteAccount(context);
                                  },
                                  child: const Text(
                                    "Chắc Chắn",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: "OpenSans",
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ))
                            ]),
                      ],
                    ),
                    barrierDismissible: false,
                    context: context,
                  ),
                  child: const UserInfoContainer(
                      iconData: FontAwesomeIcons.userTimes,
                      text: "Xoá tài khoản"),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //contact
                GestureDetector(
                    onTap: () => showDialog(
                          builder: (context) => const DialogWidget(),
                          barrierDismissible: false,
                          context: context,
                        ),
                    child: const UserInfoContainer(
                        iconData: Icons.phone, text: "Liên hệ")),
                GestureDetector(
                  onTap: () {
                    loadingScreen(context, () => const HistoryScreen());
                  },
                  child: const UserInfoContainer(
                      iconData: FontAwesomeIcons.clock, text: "Lịch sử"),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    loadingScreen(context, () => const LoginScreen());
                  },
                  child: const UserInfoContainer(
                      iconData: FontAwesomeIcons.signOut, text: "Đăng xuất"),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
