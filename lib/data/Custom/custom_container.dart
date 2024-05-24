import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserInfoContainer extends StatelessWidget {
  final IconData iconData;
  final String text;

  const UserInfoContainer({
    Key? key,
    required this.iconData,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(blurRadius: 5, spreadRadius: 3, color: Colors.grey)
        ],
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 218, 210, 210),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            iconData,
            size: 50,
            color: Colors.lightBlueAccent,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: "OpenSans",
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
