// dialog_widget.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChangeLanguage extends StatelessWidget {
  const ChangeLanguage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      height: MediaQuery.of(context).size.height * 0.35,
      child: AlertDialog(
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Chọn ngôn ngữ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "OpenSans",
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    "Tiếng Việt ",
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Image(
                    image: AssetImage("assets/language/vietnam.png"),
                    width: 50,
                    height: 50,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    "Tiếng Anh ",
                    style: TextStyle(
                      fontFamily: "OpenSans",
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Image(
                    image: AssetImage("assets/language/anh.png"),
                    width: 50,
                    height: 50,
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Text(
                    "Đóng",
                    style: TextStyle(
                        color: Colors.blue, // Replace with your primaryColor
                        fontFamily: "OpenSans",
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
