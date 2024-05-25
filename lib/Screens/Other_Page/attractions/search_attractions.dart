import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchAttractions extends StatefulWidget {
  const SearchAttractions({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SearchAttractionsState();
  }
}

class _SearchAttractionsState extends State<SearchAttractions> {
  bool showButtonCancel = false;
  bool showSuggesstions = false;
  final searchBarController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    searchBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context, '');
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.white,
              size: 22,
            )),
        title: const Text(
          'Tìm các địa điểm tham quan ',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 59, 149),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // search bar
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              // height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: const Color.fromARGB(255, 238, 155, 77),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: showButtonCancel ? 9 : 1,
                    child: TextField(
                      controller: searchBarController,
                      decoration: const InputDecoration(
                        hintText: 'Bạn muốn đi đâu?',
                      ),
                      onChanged: (value) {
                        if (value != "") {
                          setState(() {
                            showButtonCancel = true;
                            showSuggesstions = true;
                          });
                        } else {
                          setState(() {
                            showButtonCancel = false;
                            showSuggesstions = false;
                          });
                        }
                      },
                    ),
                  ),
                  Expanded(
                      flex: showButtonCancel ? 2 : 0,
                      child: Visibility(
                          visible: showButtonCancel,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                showButtonCancel = false;
                                showSuggesstions = false;
                              });

                              searchBarController.text = '';
                            },
                            child: const Icon(
                              size: 28,
                              Icons.cancel,
                              color: Color.fromARGB(255, 84, 84, 84),
                            ),
                          )))
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            showSuggesstions
                ? Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Điểm đến',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context, 'Đà nẵng');
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 190, 231, 248),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: IconButton(
                                          onPressed: () {},
                                          iconSize: 30,
                                          icon: const FaIcon(
                                              FontAwesomeIcons.building))),
                                  const SizedBox(width: 15),
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Đà nẵng,  Việt Nam",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "1605 hoạt động",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context, 'VKU Dream Fitness');
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 190, 231, 248),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: IconButton(
                                          onPressed: () {},
                                          iconSize: 30,
                                          icon: const FaIcon(
                                              FontAwesomeIcons.building))),
                                  const SizedBox(width: 15),
                                  const Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "VKU Dream Fitness",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "9605 hoạt động",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Các hoạt động trải nghiệm',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 190, 231, 248),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: RotationTransition(
                                        turns: const AlwaysStoppedAnimation(
                                            -45 / 360),
                                        child: IconButton(
                                            onPressed: () {},
                                            iconSize: 30,
                                            icon: const FaIcon(
                                                FontAwesomeIcons.flag)))),
                                const SizedBox(width: 15),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Tour địa đạo Củ Chi và đồng bằng sông Cửu Long",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "1605 hoạt động",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 190, 231, 248),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: RotationTransition(
                                        turns: const AlwaysStoppedAnimation(
                                            -45 / 360),
                                        child: IconButton(
                                            onPressed: () {},
                                            iconSize: 30,
                                            icon: const FaIcon(
                                                FontAwesomeIcons.flag)))),
                                const SizedBox(width: 15),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Tour tham quan VKU Dream Fitness và giao lưu cùng các idol",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "10605 hoạt động",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 190, 231, 248),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: RotationTransition(
                                      turns: const AlwaysStoppedAnimation(
                                          -45 / 360),
                                      child: IconButton(
                                          onPressed: () {},
                                          iconSize: 30,
                                          icon: const FaIcon(
                                              FontAwesomeIcons.flag))),
                                ),
                                const SizedBox(width: 15),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Tour tham quan VKU Dream Fitness và giao lưu cùng các idol",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "10605 hoạt động",
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 15),
                          ],
                        )
                      ],
                    ))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Tiếp tục với tìm kiếm của bạn',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 15),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(
                              context, 'Tour tham quan VKU Dream Fitness');
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 190, 231, 248),
                                    borderRadius: BorderRadius.circular(5)),
                                child: IconButton(
                                    onPressed: () {},
                                    iconSize: 30,
                                    icon: const FaIcon(
                                        FontAwesomeIcons.building))),
                            const SizedBox(width: 15),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Tour tham quan VKU Dream Fitness và giao lưu cùng các idol",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "10605 hoạt động",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
