import 'package:BookingTourApp/components/stays/view_stays_card.dart';
import 'package:BookingTourApp/components/stays/view_stays_filter.dart';
import 'package:BookingTourApp/components/stays/view_stays_sort.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ViewStays extends StatefulWidget {
  final List input;
  const ViewStays({super.key, required this.input});

  @override
  State<ViewStays> createState() => _ViewStaysState();
}

class _ViewStaysState extends State<ViewStays> {
  int optionSort = 2;

  int currentAmount = 0;

  List listOfStays = [];
  bool isSorted = false;

  // list of results that choosed from user
  List<dynamic> filters = [];

  // the results as type widget
  List<Widget> results = [];

  // remove the results that choosed from user
  Set visibilityItems = {};

  void filter() async {
    var db = FirebaseFirestore.instance;
    var titlesOfFilter = filters.map((element) => element[0]['title']);

    listOfStays.clear();

    // get all documents of hotel
    await db.collection('hotel').get().then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          List utilities = docSnapshot.data()['utilities'];

          var isContaining =
              titlesOfFilter.toSet().intersection(utilities.toSet()).isNotEmpty;

          if (isContaining) {
            listOfStays.add(docSnapshot.id);
          }
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

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
                          filter();
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
                                  return ViewStaysSort(
                                      currentOptionSort: optionSort);
                                }).then((value) {
                              if (value != null) {
                                setState(() {
                                  optionSort = value;
                                  isSorted = true;
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
                                  optionSort != 2
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
                                  return const ViewStaysFilter();
                                }).then((value) {
                              if (value != null) {
                                if (value[0] > 0) {
                                  setState(() {
                                    filters.clear();
                                    currentAmount = value[0];
                                    filters = value[1];
                                  });
                                  filter();
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
                    width: double.maxFinite,
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
                          width: 5,
                        ),
                        Expanded(
                            flex: 1,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                '${widget.input[0]} . ${widget.input[1]}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ))
            ],
          ),

          // body
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                color: const Color.fromARGB(255, 241, 241, 241),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      children: results,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ViewStaysCard(
                      listOfStays: listOfStays,
                      isSorted: isSorted,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
