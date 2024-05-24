import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  String text;

  CustomText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontFamily: "OpenSans", fontWeight: FontWeight.bold, fontSize: 15),
    );
  }
}
