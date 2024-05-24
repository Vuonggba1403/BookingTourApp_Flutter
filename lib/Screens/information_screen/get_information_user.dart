import 'package:BookingTourApp/components/curve_navigation_bar.dart';
import 'package:BookingTourApp/components/stays/field.dart';
import 'package:BookingTourApp/data/Custom/custom_text.dart';
import 'package:BookingTourApp/data/Custom/loading_screen.dart';
import 'package:BookingTourApp/data/Custom/showCustomDelightToastBar.dart';
import 'package:BookingTourApp/data/text_utils.dart';
import 'package:BookingTourApp/models/model_booking_hotel.dart';
import 'package:BookingTourApp/models/models_discount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class GetInformationUser extends StatefulWidget {
  const GetInformationUser(
      {super.key,
      required this.numberOfPeople,
      required this.hotelName,
      required this.numberOfday,
      required this.totalPrice});
  final String hotelName;
  final int numberOfday;
  final String totalPrice;
  final int numberOfPeople;

  @override
  State<GetInformationUser> createState() => _GetInformationUserState();
}

class _GetInformationUserState extends State<GetInformationUser> {
  List fields = [
    {'label': 'Tên', 'value': 'firstName'},
    {'label': 'Họ', 'value': 'lastName'},
    {'label': 'Địa chỉ email', 'value': 'email'},
    {'label': 'Điện thoại', 'value': 'phoneNumber'},
  ];

  String firstName = '';
  String lastName = '';
  String email = '';
  String phoneNumber = '';
  String? selectedValue;
  double discountPercentage = 0.0;
  bool checkError = false;
  double discountedPrice = 0.0;

  // Add this line
  void setValue(String field, String value) {
    switch (field) {
      case 'firstName':
        setState(() {
          firstName = value;
        });
        break;
      case 'lastName':
        setState(() {
          lastName = value;
        });
        break;
      case 'email':
        setState(() {
          email = value;
        });
        break;
      default:
        setState(() {
          phoneNumber = value;
        });
    }
  }

  @override
  void initState() {
    super.initState();
    discountedPrice = cleanPrice(widget.totalPrice);
  }

  double cleanPrice(String price) {
    //xoa dau cham va dau phay
    String cleanedPrice = price.replaceAll(RegExp(r'[.,]'), '');
    return double.tryParse(cleanedPrice) ?? 0.0;
  }

//ham tinh khi nhap voucher
  void updateDiscountedPrice(double discountPercentage) {
    setState(() {
      double totalPrice = cleanPrice(widget.totalPrice);
      discountedPrice = totalPrice - (totalPrice * discountPercentage / 100);
    });
  }

// add vao firebase
  Future<void> addBookingHotel() async {
    final CollectionReference bookingHotel =
        FirebaseFirestore.instance.collection('BookingHotel');
    await bookingHotel.add({
      'name_hotel': widget.hotelName,
      'number_of_peopele': widget.numberOfPeople,
      'time': DateFormat('HH:mm:ss dd/MM/yyyy').format(DateTime.now()),
      'totalDays': widget.numberOfday,
      'totalPrice': discountedPrice,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
    });
    showCustomDelightToastBar(
      context,
      "Đặt phòng thành công",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        title: const Text(
          'Điền thông tin của bạn',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 59, 149),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    height: 180,
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey[300]!),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          )
                        ]),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomText(text: "Khách sạn : ${widget.hotelName}"),
                          CustomText(
                              text:
                                  "Số người đi : ${widget.numberOfPeople} Người"),
                          CustomText(
                              text: "Số ngày đi : ${widget.numberOfday} Ngày"),
                          CustomText(
                              text: "Tổng giá tiền : ${widget.totalPrice} VND"),
                        ],
                      ),
                    ),
                  )),
              for (var item in fields)
                Field(field: item, setValue: setValue, checkError: checkError),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.discount,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "IVIVU Voucher",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue),
                        )
                      ],
                    ),
                    StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('Discount')
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
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        //loc ra nhung ma giam gia con hieu luc
                        final discountList = snapshot.data?.docs
                                .map((doc) => Discount.fromFirestore(doc))
                                .where(
                                    (discount) => discount.status != 'OLD CODE')
                                .toList() ??
                            [];

                        return DropdownButton<String>(
                          hint: const Text("Chọn mã giảm giá"),
                          value: selectedValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue;
                              discountPercentage = discountList
                                  .firstWhere(
                                      (element) => element.dis_name == newValue)
                                  .per
                                  .toDouble();
                              updateDiscountedPrice(discountPercentage);
                              // print("Chon PGG: $selectedValue");
                            });
                          },
                          items: discountList
                              .map<DropdownMenuItem<String>>((discount_name) {
                            return DropdownMenuItem<String>(
                              value: discount_name.dis_name,
                              child: Center(
                                child: Text(
                                    '${discount_name.dis_name} - Giảm : ${discount_name.per} %'),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // price and button booking
              Container(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            '${discountedPrice.toStringAsFixed(0).replaceAllMapped(
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
                          if (firstName.isEmpty ||
                              lastName.isEmpty ||
                              email.isEmpty ||
                              phoneNumber.isEmpty) {
                            setState(() {
                              checkError = true;
                            });
                          } else {
                            addBookingHotel();
                            loadingScreen(context, () => CurveBar());
                          }

                          ;
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
