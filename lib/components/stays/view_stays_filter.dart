import 'package:BookingTourApp/components/stays/customize_price.dart';
import 'package:BookingTourApp/components/wrap_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewStaysFilter extends StatefulWidget {
  const ViewStaysFilter({super.key});

  @override
  State<ViewStaysFilter> createState() => _ViewStaysFilterState();
}

class _ViewStaysFilterState extends State<ViewStaysFilter> {
  // results that user choosed
  List<dynamic> results = [];

  int currentAmount = 0;
  int totalResults = 0;

  // reset button
  bool reset = false;

  // get total results
  @override
  void initState() {
    super.initState();
    getTotalResults();
  }

  var contents = [
    {
      // list of popular filters
      'Các bộ lọc phổ biến': [
        {'title': 'Bao gồm bữa sáng', 'amount': 302},
        {'title': 'Phòng tắm riêng', 'amount': 886},
        {'title': 'Rất tốt: 8 điểm trở lên', 'amount': 674},
        {'title': 'Khách sạn', 'amount': 589},
        {'title': 'Chỗ đậu xe miễn phí', 'amount': 825},
        {'title': 'Hồ bơi', 'amount': 447},
        {'title': 'Miễn phí hủy', 'amount': 410},
        {'title': 'Nhìn ra biển', 'amount': 350},
      ]
    },
    {
      // list of facilities
      'Tiện nghi': [
        {'title': 'Xe đưa đón sân bay', 'amount': 594},
        {'title': 'Chỗ đỗ xe', 'amount': 883},
        {'title': 'Trung tâm thể dục', 'amount': 229},
        {'title': 'WiFi miễn phí', 'amount': 949},
        {'title': 'Trung tâm Spa & chăm sóc sức khoẻ', 'amount': 256},
      ]
    },
    {
      // list of facilities of room
      'Tiện nghi phòng': [
        {'title': 'Bồn tắm', 'amount': 400},
        {'title': 'Nhìn ra biển', 'amount': 350},
        {'title': 'Ban công', 'amount': 575},
        {'title': 'Phòng tắm riêng', 'amount': 886},
        {'title': 'Hồ bơi riêng', 'amount': 156},
      ]
    },
    {
      // list of stays
      'Loại chỗ nghỉ': [
        {'title': 'Nhà & căn hộ nguyên căn', 'amount': 648},
        {'title': 'Khách sạn', 'amount': 589},
        {'title': 'Căn hộ', 'amount': 268},
        {'title': 'Biệt thự', 'amount': 82},
        {'title': 'Resort', 'amount': 37},
      ]
    },
    {
      // list of meal
      'Bữa ăn': [
        {'title': 'Tự nấu', 'amount': 517},
        {'title': 'Bao gồm bữa sáng', 'amount': 302},
        {'title': 'Bao bữa sáng & bữa tối', 'amount': 8},
        {'title': 'Bao bữa sáng & bữa trưa', 'amount': 3},
        {'title': 'Tất cả các bữa', 'amount': 1},
      ]
    },
    {
      // list of beds
      'Tùy chọn giường': [
        {'title': 'Giường đôi', 'amount': 994},
        {'title': '2 giường đơn', 'amount': 361},
      ]
    },
    {
      // list of district
      'Khu vực': [
        {'title': 'Sông Hàn', 'amount': 113},
        {'title': 'Trung tâm Thành phố Đà Nẵng', 'amount': 118},
        {'title': 'Bãi biển Mỹ Khê', 'amount': 514},
        {'title': 'Bãi biển Bắc Mỹ An', 'amount': 103},
        {'title': 'Bãi biển Non Nước', 'amount': 63},
        {'title': 'Vịnh Đà Nẵng', 'amount': 49},
        {'title': 'Bán đảo Sơn Trà', 'amount': 3},
      ]
    },
    {
      // list of locations
      'Địa danh': [
        {'title': 'Cầu Rồng', 'amount': 77},
        {'title': 'Ngũ Hành Sơn', 'amount': 5},
      ]
    },
    {
      // list of rating
      'Điểm đánh giá': [
        {'titel': '5 sao', 'amount': 83},
        {'titel': '4 sao', 'amount': 276},
        {'titel': '3 sao', 'amount': 248},
        {'titel': '2 sao', 'amount': 90},
        {'titel': '1 sao', 'amount': 15},
        {'titel': 'Không xếp hạng', 'amount': 293},
      ]
    },
    {
      // list of rooms
      'Số phòng ngủ': [
        {'title': '1 phòng hoặc nhiều hơn', 'amount': 647},
        {'title': '2 phòng hoặc nhiều hơn', 'amount': 403},
        {'title': '3 phòng hoặc nhiều hơn', 'amount': 172},
        {'title': '4 phòng hoặc nhiều hơn', 'amount': 125},
      ]
    },
  ];

  // get total results
  void getTotalResults() {
    for (var list in contents) {
      var item = list.values.single;
      for (var element in item) {
        var lastIndex = element.length - 1;
        var amount = element.values.elementAt(lastIndex).hashCode;
        setState(() {
          totalResults += amount;
        });
      }
    }
  }

  // get results from user
  void getResultsFromUser(resultsFromUser) {
    if (resultsFromUser != null) {
      int amount = resultsFromUser[0]['amount'];
      if (resultsFromUser[1]['isSelected']) {
        setState(() {
          results.add(resultsFromUser);
          currentAmount += amount;
        });
      } else {
        setState(() {
          results.remove(resultsFromUser);
          currentAmount -= amount;
        });
      }
    }
  }

  String formatString(String title) {
    var length = title.length;
    if (length >= 1) {
      title = title.substring(1, length - 1);
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          flex: 1,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // divider
                Center(
                  child: Container(
                    width: 80,
                    height: 5,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 113, 113, 113),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),

                const SizedBox(height: 10),

                // reset
                GestureDetector(
                  onTap: () {
                    setState(() {
                      reset = true;
                      currentAmount = 0;
                      results = [];
                    });
                    Future.delayed(const Duration(milliseconds: 100), () {
                      setState(() {
                        reset = false;
                      });
                    });
                  },
                  child: const Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Cài lại',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(225, 0, 108, 228)),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomizePrice(),
                        const SizedBox(height: 15),

                        // divider
                        const Divider(
                          height: 2,
                          color: Color.fromARGB(255, 217, 217, 217),
                        ),

                        const SizedBox(height: 10),

                        for (var item in contents)
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formatString(item.keys.toString()),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                // catalog
                                WrapRow(
                                  contents: item.values.single,
                                  getResultsFromUser: getResultsFromUser,
                                  isReset: reset,
                                ),
                                const SizedBox(height: 10),
                                // divider
                                const Divider(
                                  height: 2,
                                  color: Color.fromARGB(255, 217, 217, 217),
                                ),

                                const SizedBox(height: 10),
                              ]),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),

        // results
        Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(color: Color.fromARGB(255, 217, 217, 217)))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  '$currentAmount trên $totalResults kết quả',
                  maxLines: 1,
                  softWrap: true,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, [currentAmount, results]);
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(225, 0, 108, 228),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    child: const Text('Hiển thị kết quả',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white))),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
