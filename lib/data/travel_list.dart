import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TravelList {
  String Image;
  String nameTravel;
  String titleTravel;
  String description;
  List<String> descriptionImg;

  TravelList(this.Image, this.nameTravel, this.titleTravel, this.description,
      this.descriptionImg);

  get length => null;
}

List<TravelList> listTravel = [
  TravelList(
      'assets/travelpictures/dragonbridge.jpg',
      'Cầu Rồng Đà Nẵng',
      'Địa Điểm Yêu Thích',
      'Cầu Rồng Đà Nẵng là một trong những điểm đến không thể bỏ qua. Tới đây, bạn không chỉ được chiêm ngưỡng khung cảnh tuyệt đẹp của dòng sông Hàn, mà còn có cơ hội thưởng thức những màn trình diễn pháo hoa hoành tráng. Cùng mình khám phá cầu Rồng Đà Nẵng trong bài viết này nhé!',
      [
        'assets/descriptiontravel/a1.jpg',
        'assets/descriptiontravel/a2.png',
        'assets/descriptiontravel/a3.png',
        'assets/descriptiontravel/a4.png',
        'assets/descriptiontravel/a5.png'
      ]),
  TravelList(
      'assets/travelpictures/phongnha.jpg',
      'Động Phong Nha - Quảng Bình',
      'Địa Điểm Yêu Thích',
      'Động Phong Nha là điểm đến hấp dẫn mà mọi tín đồ đam mê khám phá không nên bỏ lỡ. Tại đây, bạn không chỉ được hòa mình vào thiên nhiên non nước hữu tình, đẹp như tranh vẽ mà còn được tận mắt khám phá bàn tay kỳ diệu của tạo hóa từ thuở xa xưa.',
      [
        'assets/descriptiontravel/b1.jpg',
        'assets/descriptiontravel/b2.jpg',
        'assets/descriptiontravel/b3.jpg',
        'assets/descriptiontravel/b4.jpg',
        'assets/descriptiontravel/b5.jpg'
      ]),
  TravelList(
      'assets/travelpictures/nhabacho.jpeg',
      'Lưu Niệm Nhà Bác Hồ - Nghệ An',
      'Địa Điểm Yêu Thích',
      'Nhà lưu niệm Bác Hồ nằm cách trung tâm thành phố Huế khoảng 7km chính là nơi Chủ tịch Hồ Chí Minh cùng cha Nguyễn Sinh Sắc và anh trai Nguyễn Sinh Khiêm sinh sống, học tập trong những năm 1898 – 1900. Hiện tại ngôi nhà đã trở thành di tích quan trọng trong Khu Di tích lưu niệm về Người tại xã Dương Nỗ.',
      [
        'assets/descriptiontravel/c1.webp',
        'assets/descriptiontravel/c2.webp',
        'assets/descriptiontravel/c3.webp',
        'assets/descriptiontravel/c4.webp',
        'assets/descriptiontravel/c5.webp'
      ]),
  TravelList(
      'assets/travelpictures/vinhhalong.webp',
      'Vịnh Hạ Long',
      'Địa Điểm Yêu Thích',
      'Được ví như một tác phẩm nghệ thuật của thiên nhiên với hàng nghìn hòn đảo lớn nhỏ mang vẻ đẹp kỳ vĩ và sống động, Vịnh Hạ Long không chỉ là điểm đến quen thuộc của du khách trong và ngoài nước, mà còn là địa chỉ nghiên cứu của giới khoa học, từ địa chất, khảo cổ cho đến lịch sử, văn hóa…',
      [
        'assets/descriptiontravel/d1.webp',
        'assets/descriptiontravel/d2.webp',
        'assets/descriptiontravel/d3.webp',
        'assets/descriptiontravel/d4.webp',
        'assets/descriptiontravel/d5.jpg'
      ]),
];
