import 'package:BookingTourApp/components/attractions/view_attractions_card.dart';
import 'package:BookingTourApp/components/attractions/view_attractions_filter.dart';
import 'package:BookingTourApp/components/attractions/view_attractions_sort.dart';
import 'package:BookingTourApp/models/models_placed.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewAttractions extends StatefulWidget {
  const ViewAttractions({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ViewAttractionsState();
  }
}

class _ViewAttractionsState extends State<ViewAttractions> {
  int optionSort = 0;

  int currentAmount = 0;

  bool sortAndFilter = false;

  // list of results that choosed from user
  List<dynamic> filters = [];

  // the results as type widget
  List<Widget> results = [];

  // remove the results that choosed from user
  Set visibilityItems = {};

  @override
  Widget build(BuildContext context) {
    if (filters.isNotEmpty) {
      var count = 0;
      results.clear();

      for (var item in filters) {
        if (item[0] != null && item[1]['isSelected'] == true) {
          int index = count;
          visibilityItems.add({'index': index, 'visibility': true});

          results.add(Visibility(
            visible: visibilityItems.elementAt(index)['visibility'],
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                margin: const EdgeInsets.fromLTRB(0, 8, 10, 8),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color.fromARGB(255, 0, 108, 228)),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item[0].values.elementAt(0).toString(),
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 0, 108, 228)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        int amount = item[0]['amount'];
                        setState(() {
                          visibilityItems.elementAt(index)['visibility'] =
                              false;
                          currentAmount -= amount;
                          filters.removeAt(index);
                          results.removeAt(index);
                          sortAndFilter = true;
                        });
                      },
                      child: const Icon(
                        Icons.cancel_outlined,
                        color: Color.fromARGB(255, 0, 108, 228),
                      ),
                    ),
                  ],
                )),
          ));
          count++;
        }
      }
    }

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 60,
                    color: const Color.fromARGB(255, 0, 59, 149),
                  ),
                  Container(
                    height: 55,
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: Color.fromARGB(255, 170, 170, 170)))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // sort
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(15.0)),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                builder: (contex) {
                                  return FractionallySizedBox(
                                    heightFactor: 0.6,
                                    child: ViewAttractionsSort(
                                        currentOptionSort: optionSort),
                                  );
                                }).then((value) {
                              if (value != null) {
                                setState(() {
                                  optionSort = value;
                                  sortAndFilter = true;
                                });
                              }
                            });
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.sort),
                              const SizedBox(width: 5),
                              Row(
                                children: <Widget>[
                                  const Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      'Sắp xếp',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  optionSort != 0
                                      ? const Align(
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                            '.',
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.redAccent),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // filter
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return const ViewAttractionsFilter();
                                }).then((value) {
                              if (value != null) {
                                if (value[0] > 0) {
                                  setState(() {
                                    filters.clear();
                                    currentAmount = value[0];
                                    filters = value[1];
                                  });
                                  sortAndFilter = true;
                                }
                              }
                            });
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Icon(Icons.tune),
                              const SizedBox(width: 5),
                              Row(
                                children: [
                                  const Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      'Lọc',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  currentAmount > 0
                                      ? const Align(
                                          alignment: Alignment.topCenter,
                                          child: Text(
                                            '.',
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.redAccent),
                                          ),
                                        )
                                      : Container(),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),

              // serch bar
              Positioned(
                  left: 25,
                  right: 25,
                  top: 20,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            width: 3,
                            color: const Color.fromARGB(255, 238, 155, 77)),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            iconSize: 24,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const FaIcon(FontAwesomeIcons.arrowLeft)),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Đà nẵng',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        const Text(
                          ' . 30 tháng 2',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        )
                      ],
                    ),
                  ))
            ],
          ),

          // body
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.82,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Wrap(
                      children: results,
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.centerLeft,
                  //   child: Text(
                  //     '${currentAmount > 0 ? currentAmount > 0 : 1515} hoạt động',
                  //     style: const TextStyle(
                  //         fontSize: 15, fontWeight: FontWeight.w600),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 5,
                  ),
                  // list of attractions
                  ViewAttractionCard(
                    sortAndFilter: sortAndFilter,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
