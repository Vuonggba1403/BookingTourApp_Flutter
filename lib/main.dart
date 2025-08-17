import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:travelapp_flutter/firebase_options.dart';
import 'package:travelapp_flutter/screens/main_screen.dart';
import 'package:travelapp_flutter/screens/splash_screen.dart';

import 'screens/ChatBot/consts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Gemini.init(apiKey: ChatBot_API_KEY);

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Mainscreen(),
  ));
}
