import 'package:BookingTourApp/Screens/Other_Page/searchcar.dart';
import 'package:BookingTourApp/Screens/details_screen/detail_stays.dart';
import 'package:BookingTourApp/Themes/Colors.dart';
import 'package:BookingTourApp/components/curve_navigation_bar.dart';
import 'package:BookingTourApp/data/Custom/loading_screen.dart';
import 'package:BookingTourApp/models/models_rentalcar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:BookingTourApp/models/models_hotel.dart';
import 'package:BookingTourApp/models/models_placed.dart';
import 'package:BookingTourApp/data/Custom/showCustomDelightToastBar.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';

class DetailAttractionScreen extends StatefulWidget {
  final Placed placed;
  const DetailAttractionScreen({
    Key? key,
    required this.placed,
  }) : super(key: key);

  @override
  State<DetailAttractionScreen> createState() => _DetailAttractionScreenState();
}

class _DetailAttractionScreenState extends State<DetailAttractionScreen> {
  bool isFavorited = false; // theo doi trang thai
  String? favoriteId; // id cua favorite
  String? selectedValue;
  double pricecar = 0.0;
  double rentaltotalPrice = 0.0;
  @override
  void initState() {
    super.initState();
    checkIfFavorited();
    rentaltotalPrice = cleanPrice(widget.placed.money);
  }

//list hour
  final List<int> hour = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  int? selectHours;

  double cleanPrice(String price) {
    //xoa dau cham va dau phay
    String cleanedPrice = price.replaceAll(RegExp(r'[.,]'), '');
    return double.tryParse(cleanedPrice) ?? 0.0;
  }

//ham tinh khi nhap voucher
  void updateDiscountedPrice(double priceCar) {
    setState(() {
      double totalPrice = cleanPrice(widget.placed.money);
      rentaltotalPrice = totalPrice + (priceCar * 1000 * selectHours!);
    });
  }

// check xem save hay chua
  Future<void> checkIfFavorited() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .where('name', isEqualTo: widget.placed.placed)
          .get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          isFavorited = true;
          favoriteId = snapshot.docs.first.id;
        });
      }
    } catch (e) {
      print("Failed to check if favorited: $e");
    }
  }

  void _toggleFavorite() async {
    setState(() {
      isFavorited = !isFavorited;
    });

    if (isFavorited) {
      await saveFavorite(widget.placed);
      showCustomDelightToastBar(context, "Đã thêm vào yêu thích");
    } else {
      await deleteFavorite(widget.placed);
      showCustomDelightToastBar(context, "Đã xóa khỏi yêu thích");
    }
  }

//ham luu favorite
  Future<void> saveFavorite(Placed placed) async {
    try {
      CollectionReference favorites =
          FirebaseFirestore.instance.collection('favorites');
      DocumentReference docRef = await favorites.add({
        'name': placed.placed,
        'description': placed.des,
        'img': placed.img,
        'price': placed.money,
      });

      setState(() {
        favoriteId = docRef.id;
      });
    } catch (e) {
      print("Failed to add favorite: $e");
    }
  }

//ham xoa favorite
  Future<void> deleteFavorite(Placed placed) async {
    try {
      if (favoriteId != null) {
        await FirebaseFirestore.instance
            .collection('favorites')
            .doc(favoriteId)
            .delete();
      }
    } catch (e) {
      print("Failed to delete favorite: $e");
    }
  }

  // add vao firebase
  Future<void> addBookingAttraction() async {
    final CollectionReference addBookingAttraction =
        FirebaseFirestore.instance.collection('addBookingAttraction');
    await addBookingAttraction.add({
      'placed': widget.placed.placed,
      'time': DateFormat('HH:mm:ss dd/MM/yyyy').format(DateTime.now()),
      'price': rentaltotalPrice,
      'hour': selectHours,
      'car': selectedValue,
      'priceticket': widget.placed.money,
    });
    await Future.delayed(const Duration(seconds: 1));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const CurveBar()));

    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: 'Đặt tour thành công',
      autoCloseDuration: const Duration(seconds: 4),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
              height: size.height * 0.6,
              width: double.infinity,
              child: Image.network(
                widget.placed.img,
                fit: BoxFit.cover,
              )),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.arrowLeft,
                    color: Colors.white,
                  ),
                ),
                const FaIcon(
                  FontAwesomeIcons.bars,
                  color: Colors.white,
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.8,
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.placed.placed,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: _toggleFavorite,
                          child: Icon(
                            isFavorited
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavorited ? Colors.red : Colors.grey,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 3,
                            )
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            const Text(
                              "Mô tả : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                widget.placed.des,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.star, color: Colors.red, size: 16),
                            Icon(Icons.star, color: Colors.red, size: 16),
                            Icon(Icons.star, color: Colors.red, size: 16),
                            Icon(Icons.star, color: Colors.red, size: 16),
                            Icon(Icons.star, color: Colors.grey, size: 16)
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              " Giá vé : ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.red,
                                  fontFamily: "OpenSans"),
                            ),
                            Text(
                              "${widget.placed.money} VND",
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.red,
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Text("Dịch vu thuê xe đi kèm tour",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: "OpenSans")),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Số giờ thuê : ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                fontFamily: "OpenSans")),
                        DropdownButton2<int>(
                          hint: const Text("Chọn giờ"),
                          value: selectHours,
                          items: hour.map((int item) {
                            return DropdownMenuItem<int>(
                              value: item,
                              child: Text(item.toString()),
                            );
                          }).toList(),
                          onChanged: (int? value) {
                            setState(() {
                              selectHours = value;
                              if (selectedValue != null) {
                                updateDiscountedPrice(pricecar);
                              }
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Chọn xe : ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                fontFamily: "OpenSans")),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('rentalcar')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            }

                            final rentalList = snapshot.data?.docs
                                    .map((doc) => RentalCar.fromFirestore(doc))
                                    .toList() ??
                                [];

                            return DropdownButton<String>(
                              hint: const Text("VD : HuynDai"),
                              value: selectedValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue;
                                  pricecar = double.parse(rentalList
                                      .firstWhere(
                                          (element) => element.type == newValue)
                                      .price);
                                  updateDiscountedPrice(pricecar);
                                });
                              },
                              items: rentalList.map<DropdownMenuItem<String>>(
                                  (discount_name) {
                                return DropdownMenuItem<String>(
                                  value: discount_name.type,
                                  child: Text(
                                      '${discount_name.type} - ${discount_name.price} VND/hour'),
                                );
                              }).toList(),
                            );
                          },
                        )
                      ],
                    ),
                    const Text("Gợi ý khách sạn",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: "OpenSans")),
                    const SizedBox(height: 10),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('hotel')
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: SpinKitDancingSquare(
                                color: Colors.black,
                                duration: Duration(seconds: 2),
                                size: 45.0,
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          }

                          // so sanh de loc khach san theo dia diem
                          final hotelList = snapshot.data?.docs
                                  .map((doc) => Hotel.fromFirestore(doc))
                                  .where((hotel) =>
                                      hotel.placed == widget.placed.placed)
                                  .toList() ??
                              [];
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: hotelList.map((hotel) {
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: Stack(children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            // color: Colors.red,
                                            image: DecorationImage(
                                                image: NetworkImage(hotel.img),
                                                fit: BoxFit.cover),
                                          ),
                                          width: 120,
                                          height: 120,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Expanded(
                                                child: Text(
                                                  softWrap: true,
                                                  hotel.name,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  // widget.hotel.placed,
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.yellow,
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(20))),
                                            width: 60,
                                            height: 25,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                const FaIcon(
                                                  FontAwesomeIcons.bolt,
                                                  size: 20,
                                                  color: Color.fromARGB(
                                                      224, 255, 106, 0),
                                                ),
                                                Text(
                                                  "${hotel.percent.toString()}%",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          224, 255, 106, 0)),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ]),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    )
                                  ],
                                );
                              }).toList(),
                            ),
                          );
                        }),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                width: size.width,
                height: size.height * 0.1,
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${rentaltotalPrice.toStringAsFixed(0).replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match match) => '${match[1]}.',
                                )} VND',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                            )),
                        const SizedBox(
                          height: 3,
                        ),
                        const Text(
                          'Đã bao gồm thuế và phí',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),

                    const SizedBox(
                      width: 20,
                    ),

                    // button book
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          addBookingAttraction();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color.fromARGB(255, 0, 59, 149),
                          ),
                          child: const Center(
                              child: Text(
                            'Đặt ngay',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
