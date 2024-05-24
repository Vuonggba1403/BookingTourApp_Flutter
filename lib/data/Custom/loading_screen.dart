import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

void loadingScreen(
    BuildContext context, Widget Function() screenBuilder) async {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: SpinKitThreeInOut(
        color: Colors.lightGreenAccent,
        size: 45.0,
      ),
    ),
  );
  await Future.delayed(const Duration(milliseconds: 500));

  Navigator.pop(context);

  Navigator.push(
      context, MaterialPageRoute(builder: (context) => screenBuilder()));
}
