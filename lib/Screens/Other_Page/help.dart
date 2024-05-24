import 'package:BookingTourApp/Themes/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowLeft,
              color: Colors.white,
            )),
        title: const Text(
          'Giải đáp',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "I.Các câu hỏi thường gặp",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Vui lòng đọc các bài viết tin cậy dưới đây.",
                style: TextStyle(color: Colors.grey, fontSize: 15),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 2,
                        color: Colors.grey,
                        spreadRadius: 2,
                      )
                    ]),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Đổi lịch bay cho tôi",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                fontFamily: "OpenSans"),
                          ),
                          FaIcon(
                            FontAwesomeIcons.chevronRight,
                            color: Colors.blue,
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Cách sửa hoặc đổi tên hành khách bay",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                fontFamily: "OpenSans"),
                          ),
                          FaIcon(
                            FontAwesomeIcons.chevronRight,
                            color: Colors.blue,
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Mua thêm hành lý",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                fontFamily: "OpenSans"),
                          ),
                          FaIcon(
                            FontAwesomeIcons.chevronRight,
                            color: Colors.blue,
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Yêu cầu hoá đơn GTGT ở Việt Nam",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                fontFamily: "OpenSans"),
                          ),
                          FaIcon(
                            FontAwesomeIcons.chevronRight,
                            color: Colors.blue,
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Đổi lịch bay cho tôi",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                fontFamily: "OpenSans"),
                          ),
                          FaIcon(
                            FontAwesomeIcons.chevronRight,
                            color: Colors.blue,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.circleQuestion,
                    color: Colors.yellow,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      "Chúng tôi vẫn còn nhiều bài  viết đáng tin  cậy hơn dành cho bạn trên Trung tâm Trợ giúp.",
                      style: TextStyle(fontFamily: "OpenSans"),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "II. Điều khoản và điều kiện sử dụng",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: "OpenSans",
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  softWrap: true,
                  style: TextStyle(fontFamily: "OpenSans", fontSize: 15),
                  "Chào mừng bạn đến với ứng dụng đặt tour của chúng tôi. Trước khi bạn sử dụng ứng dụng này, vui lòng đọc kỹ các điều khoản và điều kiện sau đây. Việc sử dụng ứng dụng này đồng nghĩa với việc bạn đã đồng ý tuân thủ các điều khoản và điều kiện này. Nếu bạn không đồng ý với bất kỳ điều khoản nào dưới đây, vui lòng ngừng sử dụng ứng dụng của chúng tôi."),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  softWrap: true,
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  "1.Dịch Vụ Cung Cấp"),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  softWrap: true,
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 15,
                  ),
                  "• Ứng dụng của chúng tôi cung cấp dịch vụ đặt tour và các dịch vụ liên quan."),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  softWrap: true,
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 15,
                  ),
                  "• Chúng tôi cung cấp thông tin chi tiết về các tour, bao gồm giá cả, điểm đến, thời gian và các điều kiện khác."),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  softWrap: true,
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  "2.Quy định thanh toán"),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  softWrap: true,
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 15,
                  ),
                  "• Bằng cách sử dụng ứng dụng của chúng tôi, bạn đồng ý thanh toán các khoản phí liên quan đến việc đặt tour theo các phương thức thanh toán được chấp nhận."),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  softWrap: true,
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                  "3.Chính sách huỷ đặt tour"),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  softWrap: true,
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 15,
                  ),
                  "• Để biết chi tiết về chính sách hủy tour, vui lòng kiểm tra thông tin chi tiết của từng tour trên ứng dụng của chúng tôi."),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  softWrap: true,
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 15,
                  ),
                  "• Các chính sách hủy tour có thể thay đổi tùy thuộc vào từng tour cụ thể."),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  softWrap: true,
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                  "Cảm ơn bạn đã đặt tour chúng tôi !"),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.maxFinite,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 255, 132, 0)),
                child: const Center(
                  child: Text(
                    "Chuyển đến trung tâm trợ giúp",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "OpenSans"),
                  ),
                ),
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
