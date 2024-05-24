import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectTypeOfRooms extends StatefulWidget {
  final List previousOptions;
  const SelectTypeOfRooms({super.key, required this.previousOptions});

  @override
  State<SelectTypeOfRooms> createState() => _SelectTypeOfRoomsState();
}

class _SelectTypeOfRoomsState extends State<SelectTypeOfRooms> {
  int numberOfRooms = 1;
  int numberOfAdults = 2;
  int numberOfChilds = 0;

  @override
  void initState() {
    super.initState();
    setOptions();
  }

  void setOptions() {
    if (widget.previousOptions.isNotEmpty) {
      setState(() {
        numberOfRooms = widget.previousOptions[0];
        numberOfAdults = widget.previousOptions[1];
        numberOfChilds = widget.previousOptions[2];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List typeOfRooms = [numberOfRooms, numberOfAdults, numberOfChilds];
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 80,
                      height: 5,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 113, 113, 113),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Chọn phòng và khách",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Phòng',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 221, 221, 221)),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                iconSize: 20,
                                onPressed: () {
                                  if (numberOfRooms >= 2) {
                                    setState(() {
                                      numberOfRooms -= 1;
                                    });
                                  }
                                },
                                icon: const FaIcon(FontAwesomeIcons.minus)),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                numberOfRooms.toString(),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            IconButton(
                              iconSize: 20,
                              onPressed: () {
                                setState(() {
                                  numberOfRooms += 1;
                                });
                              },
                              icon: const FaIcon(FontAwesomeIcons.plus),
                              color: const Color.fromARGB(255, 0, 108, 228),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Người lớn',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 221, 221, 221)),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                iconSize: 20,
                                onPressed: () {
                                  if (numberOfAdults >= 2) {
                                    setState(() {
                                      numberOfAdults -= 1;
                                    });
                                  }
                                },
                                icon: const FaIcon(FontAwesomeIcons.minus)),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                numberOfAdults.toString(),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            IconButton(
                              iconSize: 20,
                              onPressed: () {
                                setState(() {
                                  numberOfAdults += 1;
                                });
                              },
                              icon: const FaIcon(FontAwesomeIcons.plus),
                              color: const Color.fromARGB(255, 0, 108, 228),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Trẻ em',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 3),
                          Text(
                            '0 - 15 tuổi',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 128, 128, 128)),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 221, 221, 221)),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                iconSize: 20,
                                onPressed: () {
                                  if (numberOfChilds >= 1) {
                                    setState(() {
                                      numberOfChilds -= 1;
                                    });
                                  }
                                },
                                icon: const FaIcon(FontAwesomeIcons.minus)),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                numberOfChilds.toString(),
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            IconButton(
                              iconSize: 20,
                              onPressed: () {
                                setState(() {
                                  numberOfChilds += 1;
                                });
                              },
                              icon: const FaIcon(FontAwesomeIcons.plus),
                              color: const Color.fromARGB(255, 0, 108, 228),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(
                  top: BorderSide(color: Color.fromARGB(255, 192, 192, 192))),
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context, typeOfRooms);
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: const BoxDecoration(
                  border: Border(),
                  color: Color.fromARGB(255, 0, 108, 228),
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: const Center(
                  child: Text(
                    'Áp dụng',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
