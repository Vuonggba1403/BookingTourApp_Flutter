// dialog_widget.dart
import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        const SizedBox(
          height: 10,
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("House Tour",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      color: Colors.lightBlueAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Địa chỉ :",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    "22 Phan Đình Thông - Ngũ Hành Sơn - Đà Nẵng",
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Số điện thoại :",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "0123456789",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  "Gmail :",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Bookingtour@gmail.com",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Đóng",
                  style: TextStyle(
                      color: Colors.blue, // Replace with your primaryColor
                      fontFamily: "OpenSans",
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )),
          ],
        )
      ],
    );
  }
}
