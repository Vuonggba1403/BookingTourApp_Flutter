import 'package:BookingTourApp/components/attractions/custom_wrap_row.dart';
import 'package:BookingTourApp/components/wrap_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewAttractionsFilter extends StatefulWidget {
  const ViewAttractionsFilter({super.key});

  @override
  State<ViewAttractionsFilter> createState() => _ViewAttractionsFilterState();
}

class _ViewAttractionsFilterState extends State<ViewAttractionsFilter> {
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

  // list of catalog
  var catalogs = [
    {'catalog': 'Tour du lịch', 'amount': 1037},
    {'catalog': 'Hoạt động', 'amount': 80},
    {'catalog': 'Phương tiện đi lại & dịch vụ khác', 'amount': 118},
    {'catalog': 'Địa điểm tham quan', 'amount': 3},
    {'catalog': 'Địa danh', 'amount': 1},
  ];

  // list of price
  List<Map<String, dynamic>> prices = [
    {'from': 0, 'to': 535618, 'amount': 44},
    {'from': 535618, 'to': 1071236, 'amount': 1226},
    {'from': 1071237, 'to': 2008568, 'amount': 31},
    {'from': 2008569, 'to': 3344038, 'amount': 25},
    {'from': '3344038+', 'to': null, 'amount': 18},
  ];

  // list of more
  List<Map<String, dynamic>> mores = [
    {'content': 'Ưu đãi & giảm giá', 'amount': 15},
    {'content': 'Miễn phí hủy', 'amount': 1454},
  ];

  // list of cities
  List<Map<String, dynamic>> cities = [
    {'city': 'Hội An ', 'amount': 760},
    {'city': 'Đà Nẵng', 'amount': 715},
    {'city': 'Xom Son Thuy', 'amount': 4},
    {'city': 'VKU', 'amount': 6447},
  ];

  // get total results
  void getTotalResults() {
    var activities = [catalogs, prices, mores, cities];
    activities.forEach((element) {
      element.forEach((element) {
        var lastIndex = element.length - 1;
        int amount = element.values.elementAt(lastIndex);
        totalResults += amount;
      });
    });
  }

  // get results from user
  void getResultsFromUser(dynamic resultsFromUser) async {
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
                        const Text(
                          'Lọc theo',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 15),

                        // catalog
                        const Text(
                          'Hạng mục',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        // catalog
                        WrapRow(
                          contents: catalogs,
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

                        // price
                        const Text(
                          'Giá',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                        
                        CustomWrapRow(
                            contents: prices,
                            getResultsFromUser: getResultsFromUser,
                            isReset: reset),
                        const SizedBox(height: 10),

                        // divider
                        const Divider(
                          height: 2,
                          color: Color.fromARGB(255, 217, 217, 217),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          'Khác',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                        // more
                        WrapRow(
                          contents: mores,
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

                        const Text(
                          'Thành phố',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                        // cities
                        WrapRow(
                          contents: cities,
                          getResultsFromUser: getResultsFromUser,
                          isReset: reset,
                        ),

                        const SizedBox(height: 10),
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
              Text(
                '$currentAmount trên $totalResults kết quả',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
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
