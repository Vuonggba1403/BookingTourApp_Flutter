import 'package:BookingTourApp/Themes/Colors.dart';
import 'package:BookingTourApp/data/car_list.dart';
import 'package:BookingTourApp/models/models_rentalcar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CarDetailScreen extends StatefulWidget {
  const CarDetailScreen(this.rentalcar, {super.key});
  final RentalCar rentalcar;

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  TextEditingController _number = TextEditingController();

//giai phong bo nho
  void dispose() {
    _number.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // image screen
          Image.asset(
            "assets/map.png",
            width: double.maxFinite,
            height: double.maxFinite,
            fit: BoxFit.cover,
          ),
          // title
          carDetailAppbar(context),
          Positioned(
            left: 10,
            right: 10,
            bottom: 25,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(
                    10,
                  ),
                  margin: const EdgeInsets.only(top: 45),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      primaryColor,
                      backroundColor3,
                      secondaryColor,
                    ]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  //
                  child: Column(
                    children: [
                      cardInformation(),
                      const Divider(
                        height: 15,
                        color: Colors.white70,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            "assets/driver.png",
                            height: 150,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.rentalcar.driver,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      Text(
                                        widget.rentalcar.des,
                                        softWrap: true,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  Text(
                                    widget.rentalcar.rate,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Row(
                                    children: [
                                      Icon(Icons.star,
                                          color: Colors.red, size: 16),
                                      Icon(Icons.star,
                                          color: Colors.red, size: 16),
                                      Icon(Icons.star,
                                          color: Colors.red, size: 16),
                                      Icon(Icons.star,
                                          color: Colors.red, size: 16),
                                      Icon(Icons.star,
                                          color: Colors.grey, size: 16)
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              // Button call
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  //button thue xe
                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        builder: (context) => AlertDialog(
                                          shape: const RoundedRectangleBorder(),
                                          actions: [
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      textAlign:
                                                          TextAlign.center,
                                                      softWrap: true,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      "Dịch vụ này chỉ áp dụng với những ai đặt tour ở app !",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text(
                                                  "OK",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                          ],
                                        ),
                                        barrierDismissible: false,
                                        context: context,
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.red,
                                      ),
                                      child: const Text(
                                        "Thuê ngay",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ))
                        ],
                      )
                    ],
                  ),
                ),
                // for car image
                Positioned(
                  right: 20,
                  child: Hero(
                    tag: widget.rentalcar.img,
                    child: Image.network(
                      widget.rentalcar.img,
                      height: 100,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column cardInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.rentalcar.price,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const Text(
          "Giá/h",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CarItems(
                name: "Hãng xe",
                value: widget.rentalcar.type,
                textColor: Colors.black),
            CarItems(
                name: "Biển số xe",
                value: widget.rentalcar.license_plate,
                textColor: Colors.black),
            CarItems(
                name: "Loại xe",
                value: widget.rentalcar.seat,
                textColor: Colors.black),
          ],
        ),
      ],
    );
  }

  SafeArea carDetailAppbar(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          const Text(
            "Chi tiết xe",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          // hien thi hop thoai
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => AlertDialog(
                  actions: [
                    const Align(
                        alignment: Alignment.center,
                        child: Text(
                          softWrap: true,
                          "Chúc quý khách có một chuyến đi vui vẻ !",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Image.asset(
                        "assets/giphy.gif",
                        width: 100,
                        height: 100,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Đóng"))
                  ],
                ),
              );
            },
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ));
  }
}
