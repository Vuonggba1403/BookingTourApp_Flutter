import 'dart:math';
import 'package:BookingTourApp/Screens/information_screen/get_information_user.dart';
import 'package:BookingTourApp/Screens/information_screen/information_hotel.dart';
import 'package:BookingTourApp/Themes/Colors.dart';
import 'package:BookingTourApp/data/Custom/loading_screen.dart';
import 'package:BookingTourApp/data/Custom/showCustomDelightToastBar.dart';
import 'package:BookingTourApp/models/models_hotel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

class ViewDetailStays extends StatefulWidget {
  final Hotel hotel;
  final String newprice;

  //random picture
  List<String> imageUrls = [
    'assets/images/hotel.jpg',
    'assets/images/hotel0.jpg',
    'assets/images/hotel1.jpg',
    'assets/images/hotel2.jpg',
    'assets/images/hotel3.jpg',
    'assets/images/hotel4.jpg',
    'assets/images/hotel5.jpg',
    'assets/images/hotel6.jpg',
    'assets/images/hotel7.jpg',
    'assets/images/hotel8.jpg',
  ];
  List<String> generateRandomUrls() {
    List<String> shuffledUrls = List.from(imageUrls)..shuffle();
    List<String> randomUrls =
        shuffledUrls.sublist(0, min(3, shuffledUrls.length));
    return randomUrls;
  }

  // final genaralnfor;
  ViewDetailStays({super.key, required this.hotel, required this.newprice});

  @override
  State<ViewDetailStays> createState() => _ViewDetailStaysState();
}

class _ViewDetailStaysState extends State<ViewDetailStays> {
  bool isFavorited = false; // theo doi trang thai
  String? favoriteId; // id cua favorite
  int numberOfDays = 0;

  @override
  void initState() {
    super.initState();
    checkIfFavorited();
  }

  String formatPrice(price) {
    final f = NumberFormat("###,###.###", "tr_TR");
    return f.format(price);
  }

// check xem save hay chua
  Future<void> checkIfFavorited() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .where('name', isEqualTo: widget.hotel.name)
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
      await saveFavorite(widget.hotel);
      showCustomDelightToastBar(context, "Đã thêm vào yêu thích");
    } else {
      await deleteFavorite(widget.hotel);
      showCustomDelightToastBar(context, "Đã xóa khỏi yêu thích");
    }
  }

//ham luu favorite
  Future<void> saveFavorite(Hotel placed) async {
    try {
      CollectionReference favorites =
          FirebaseFirestore.instance.collection('favorites');
      DocumentReference docRef = await favorites.add({
        'name': widget.hotel.name,
        'description': widget.hotel.des,
        'img': widget.hotel.img,
        'price': widget.hotel.oldprice,
      });

      setState(() {
        favoriteId = docRef.id;
      });
    } catch (e) {
      print("Failed to add favorite: $e");
    }
  }

//ham xoa favorite
  Future<void> deleteFavorite(Hotel placed) async {
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

  List<Widget> tabs = [
    //booking room
    const Tab(
      icon: Icon(
        Icons.home,
        color: Colors.grey,
      ),
    ),
    //information
    const Tab(
      icon: Icon(
        Icons.info,
        color: Colors.grey,
      ),
    )
  ];

  //ChooseRoom
  String selectedDate = '';
  bool showPickerDate = false;
  TextEditingController _number = TextEditingController();
  //giai phong bo nho
  void dispose() {
    _number.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTimeRange? userSelectedDate = await showDateRangePicker(
        context: context,
        firstDate: DateTime(currentDate.year, currentDate.month),
        currentDate: DateTime.now(),
        lastDate: DateTime(currentDate.year + 1, 12));

    if (userSelectedDate != null) {
      var startDate = userSelectedDate.start;
      var endDate = userSelectedDate.end;

      // Tính số ngày trong khoảng đã chọn
      int numberOfDays = endDate.difference(startDate).inDays;

      // Format ngày bắt đầu và kết thúc thành chuỗi
      var formattedStartDate = formatDate(startDate);
      var formattedEndDate = formatDate(endDate);

      // Hiển thị số ngày đã chọn trong selectedDate
      setState(() {
        selectedDate = '$formattedStartDate - $formattedEndDate';
        this.numberOfDays = numberOfDays; // Gán số ngày vào biến numberOfDays
      });
    }

    String startDate = '';
    String endDate = '';

    //caculator totalPrice
    String totalPrice = (double.parse(widget.newprice) *
            double.parse(_number.text) /
            2 *
            numberOfDays)
        .toStringAsFixed(3)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );
  }

  Future<void> saveBookingInfo() async {
    if (selectedDate.isEmpty || _number.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng chọn ngày và nhập số người.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    String startDate = '';
    String endDate = '';

    // Tính totalPrice
    String totalPrice = (double.parse(widget.newprice) *
            double.parse(_number.text) /
            2 *
            numberOfDays)
        .toStringAsFixed(3)
        .replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );

    // Kiểm tra và lấy ngày bắt đầu và kết thúc
    if (selectedDate.isNotEmpty) {
      List<String> dates = selectedDate.split(' - ');
      startDate = dates[0];
      endDate = dates[1];
    }
    int numberOfPeople = int.tryParse(_number.text) ?? 0;

    // Chuyển sang màn hình GetInformationUser
    loadingScreen(
        context,
        () => GetInformationUser(
            hotelName: widget.hotel.name,
            numberOfday: numberOfDays,
            numberOfPeople: numberOfPeople,
            totalPrice: totalPrice));
  }

  String formatDate(DateTime date) {
    String formatedDate = DateFormat('dd/MM/yyyy').format(date);
    return formatedDate.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const FaIcon(
                FontAwesomeIcons.arrowLeft,
                color: Colors.white,
                size: 22,
              )),
          title: Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      widget.hotel.placed,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Image.asset(
                      "assets/language/vietnam.png",
                      width: 40,
                      height: 40,
                    )
                  ],
                ),
              )),
          backgroundColor: primaryColor),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Container(
                  color: const Color.fromARGB(255, 241, 241, 241),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // images and name
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            StaggeredGrid.count(
                              crossAxisCount: 6,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              children: [
                                ...widget.generateRandomUrls().map((imageUrl) {
                                  return StaggeredGridTile.count(
                                    crossAxisCellCount: 3,
                                    mainAxisCellCount: 3,
                                    child: Image.asset(
                                      imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }).toList(),
                                StaggeredGridTile.count(
                                  crossAxisCellCount: 2,
                                  mainAxisCellCount: 3,
                                  child: Container(
                                    color: Colors.grey.withOpacity(0.5),
                                    child: Center(
                                      child: Text(
                                        '+${widget.imageUrls.length + 30}',
                                        style: const TextStyle(
                                          fontSize: 26,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            // name
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  widget.hotel.name,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                                //favorite
                                GestureDetector(
                                  onTap: _toggleFavorite,
                                  child: Icon(
                                    isFavorited
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color:
                                        isFavorited ? Colors.red : Colors.grey,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),

                            // divider
                            const Divider(
                              height: 2,
                              color: Color.fromARGB(255, 217, 217, 217),
                            ),
                            const SizedBox(
                              height: 15,
                            ),

                            // address
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  children: [
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 26,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Địa chỉ khách sạn',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  widget.hotel.detail_placed,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      // infor of room
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Giá từ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                    const SizedBox(
                                      width: 80,
                                    ),
                                    Container(
                                      color: Colors.yellow,
                                      width: 100,
                                      height: 30,
                                      child: Center(
                                        child: Text(
                                          "Giảm giá ${widget.hotel.percent}%",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text("VND ${widget.hotel.oldprice}",
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.red,
                                            decoration:
                                                TextDecoration.lineThrough)),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Text('${widget.newprice} VND',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.green,
                                          fontWeight: FontWeight.w700,
                                        ))
                                  ],
                                ),
                                const Text(
                                  'Mỗi đêm/ 2 Người',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: const FaIcon(FontAwesomeIcons.arrowRight))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      // infor check in
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: DefaultTabController(
                          length: 2,
                          child: Column(
                            children: [
                              TabBar(
                                tabs: tabs,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height: 300,
                                child: TabBarView(
                                  children: [
                                    ChooseRoom(context),
                                    InformationHotel(widget: widget),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )),
          GestureDetector(
            onTap: () {
              saveBookingInfo();
              // loadingScreen(
              //     context,
              //     () => GetInformationUser(
              //           hotelName: widget.hotel.name,
              //         ));
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: const EdgeInsets.symmetric(vertical: 15),
              decoration: const BoxDecoration(
                border: Border(),
                color: Color.fromARGB(255, 0, 108, 228),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: const Center(
                child: Text(
                  'Đặt ngay',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Scaffold ChooseRoom(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    "Chọn Ngày Đi - Ngày Về",
                    style: TextStyle(
                        fontFamily: "OpenSans",
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(7),
                      border: Border.all(color: Colors.black87, width: 1)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 19.0, vertical: 11.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(
                        Icons.calendar_month,
                        size: 25,
                        color: Color.fromARGB(255, 84, 84, 84),
                      ),
                      Text(
                        selectedDate != ''
                            ? selectedDate
                            : "Th 2, 29 tháng 2 - th3 30 tháng 2",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const Text(
                    'Phòng Dành Cho ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 0, 148, 228)),
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                          width: 2,
                          color: Colors.black,
                        )),
                    child: TextFormField(
                      controller: _number,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 0, 148, 228)),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        suffixIconColor: Colors.white,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const Text(
                    ' Người',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 0, 148, 228)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Giá cho: ',
                    style: TextStyle(fontSize: 15),
                  ),
                  Icon(
                    Icons.person,
                    size: 20,
                  ),
                  Icon(
                    Icons.person,
                    size: 20,
                  ),
                  Text(
                    ' /VND',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.bed,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Phòng Dành Cho Du Lịch',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Diện tích: ',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '25m\u00b2',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.credit_card_off,
                    size: 20,
                    color: Color.fromARGB(255, 78, 203, 113),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Không cần thẻ tín dụng',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 78, 203, 113)),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.restart_alt_rounded,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Hoàn tiền một phần',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.wifi,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'WiFi Miễn Phí',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.snowing,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Điều hòa không khí',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bathtub_outlined,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Phòng tắm riêng',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.tv,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'TV màn hình phẳng',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
