import 'package:BookingTourApp/Screens/GeminiChat/constants/consts.dart';
import 'package:BookingTourApp/Screens/Other_Page/attractions/view_attractions.dart';
import 'package:BookingTourApp/Screens/Other_Page/help.dart';
import 'package:BookingTourApp/Screens/Other_Page/stays/view_stays.dart';
import 'package:BookingTourApp/Screens/details_screen/detail_stays.dart';
import 'package:BookingTourApp/Screens/details_screen/details_attractions.dart';
import 'package:BookingTourApp/Screens/details_screen/details_car.dart';
import 'package:BookingTourApp/Screens/Other_Page/searchcar.dart';
import 'package:BookingTourApp/Screens/PagescreenHome/news.dart';
import 'package:BookingTourApp/Screens/auth/Login.dart';
import 'package:BookingTourApp/Screens/auth/Register.dart';
import 'package:BookingTourApp/Screens/auth/Splash.dart';
import 'package:BookingTourApp/Screens/PagescreenHome/discount_screen.dart';
import 'package:BookingTourApp/components/curve_navigation_bar.dart';
import 'package:BookingTourApp/Screens/information_screen/get_information_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Gemini.init(apiKey: GEMINI_API_KEY);
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CurveBar(),
  ));
}
