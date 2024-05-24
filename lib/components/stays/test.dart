import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class TestAddData extends StatefulWidget {
  const TestAddData({super.key});

  @override
  State<TestAddData> createState() => _TestAddDataState();
}

class _TestAddDataState extends State<TestAddData> {
  var contents = [
    // list of popular filters
    'Bao gồm bữa sáng',
    'Phòng tắm riêng',
    'Rất tốt: 8 điểm trở lên',
    'Khách sạn',
    'Chỗ đậu xe miễn phí',
    'Hồ bơi',
    'Miễn phí hủy',
    'Nhìn ra biển',

    // list of facilities
    'Xe đưa đón sân bay',
    'Chỗ đỗ xe',
    'Trung tâm thể dục',
    'WiFi miễn phí',
    'Trung tâm Spa & chăm sóc sức khoẻ',

    // list of facilities of room
    'Bồn tắm',
    'Nhìn ra biển',
    'Ban công',
    'Phòng tắm riêng',
    'Hồ bơi riêng',

    // list of stays
    'Nhà & căn hộ nguyên căn',
    'Khách sạn',
    'Căn hộ',
    'Biệt thự',
    'Resort',

    // list of meal
    'Tự nấu',
    'Bao gồm bữa sáng',
    'Bao bữa sáng & bữa tối',
    'Bao bữa sáng & bữa trưa',
    'Tất cả các bữa',

    // list of beds
    'Giường đôi',
    '2 giường đơn',

    // list of district
    'Sông Hàn',
    'Trung tâm Thành phố Đà Nẵng',
    'Bãi biển Mỹ Khê',
    'Bãi biển Bắc Mỹ An',
    'Bãi biển Non Nước',
    'Vịnh Đà Nẵng',
    'Bán đảo Sơn Trà',

    // list of locations
    'Cầu Rồng', 'Ngũ Hành Sơn',

    // list of rating
    '5 sao',
    '4 sao',
    '3 sao',
    '2 sao',
    '1 sao',
    'Không xếp hạng',

    // list of rooms
    '1 phòng hoặc nhiều hơn',
    '2 phòng hoặc nhiều hơn',
    '3 phòng hoặc nhiều hơn',
    '4 phòng hoặc nhiều hơn',
  ];

  List getData() {
    var items = [];
    for (var i = 0; i < 10; i++) {
      var element = "";
      do {
        var randomNumber = Random().nextInt(48);
        element = contents[randomNumber];
      } while (items.contains(element));

      items.add(element);
    }
    return items;
  }

  void addData() {
    var db = FirebaseFirestore.instance;
    Map<String, dynamic> data = {
      'placed': 'Đà Nẵng',
      'img': '',
      'rate': '',
      'percent': '',
      'des': '',
      'detail_placed': '',
      'oldprice': '',
      'name': '',
    };
    for (var i = 0; i < 3; i++) {
      var items = getData();
      data.addAll({'utilities': items});
      db.collection("hotel").add(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    addData();
    return const Placeholder();
  }
}
