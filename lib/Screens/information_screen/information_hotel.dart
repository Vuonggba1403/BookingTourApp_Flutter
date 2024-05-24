// infor of room
import 'package:BookingTourApp/Screens/details_screen/detail_stays.dart';
import 'package:BookingTourApp/Themes/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comment_box/comment/comment.dart';

class InformationHotel extends StatelessWidget {
  const InformationHotel({
    super.key,
    required this.widget,
  });

  final ViewDetailStays widget;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Text(
              widget.hotel.des,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // divider
          const Divider(
            height: 2,
            color: Color.fromARGB(255, 217, 217, 217),
          ),
          const SizedBox(
            height: 20,
          ),
          // rating
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // point
              Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color:
                        int.parse(widget.hotel.rate.replaceAll('.', '')) >= 80
                        // widget.hotel.rate >= 80
                            ? primaryColor
                            : Colors.red,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Text(
                    widget.hotel.rate.toString(),
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  )),
              const SizedBox(
                width: 10,
              ),
              // amount of comment
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        int.parse(widget.hotel.rate.replaceAll('.', '')) > 80
                        // widget.hotel.rate >= 80
                            ? "Tuyệt hảo"
                            : "Tốt",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(Icons.star, color: Colors.red, size: 16),
                      const Icon(Icons.star, color: Colors.red, size: 16),
                      const Icon(Icons.star, color: Colors.red, size: 16),
                      const Icon(Icons.star, color: Colors.red, size: 16),
                      const Icon(Icons.star, color: Colors.grey, size: 16)
                    ],
                  ),
                  const Text(
                    'Xem tất cả 267 đánh giá',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color.fromARGB(255, 58, 58, 58)),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const Text("Bình luận",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(
            height: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // infor
              Row(
                children: [
                  // avatar
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: ClipOval(
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(144),
                        child: Image.asset(
                          'assets/images/avatar.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  // name
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Godfather',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 20,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/nationality.png',
                                fit: BoxFit.fill),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                              'Việt Nam',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 63, 63, 63)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),

              const Text(
                '"phòng sạch sẽ, rộng rãi. Rất gần biển lại bên cạnh có 1 quán hải sản rất ngon."',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20,
              ),
              // divider
              const Divider(
                height: 2,
                color: Color.fromARGB(255, 217, 217, 217),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
