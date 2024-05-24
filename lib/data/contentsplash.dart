import 'package:flutter/material.dart';

class UnbordingContent {
  String image;
  String discription;
  Color colorsplash;

  UnbordingContent(
      {required this.image,
      required this.discription,
      required this.colorsplash});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      image: 'assets/SplashImages/sp1.jpg',
      colorsplash: const Color.fromARGB(255, 131, 166, 194),
      discription:
          "Bắt đầu những điều bạn yêu thích bằng một chuyến hành trình"),
  UnbordingContent(
      image: 'assets/SplashImages/sp2.jpg',
      colorsplash: const Color.fromARGB(255, 239, 145, 102),
      discription: "Những điều thú vị khi du lịch quanh ta cần được khám phá"),
  UnbordingContent(
      image: 'assets/SplashImages/sp3.jpg',
      colorsplash: const Color.fromARGB(255, 134, 216, 165),
      discription:
          "Góp phần tạo nên những kỷ niệm đẹp của tuổi trẻ để khỏi phải nuối tiếc"),
];
