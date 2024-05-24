import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:BookingTourApp/Themes/Colors.dart';
import 'package:BookingTourApp/models/news_models.dart';

class DetailNewsScreen extends StatelessWidget {
  final News news;

  const DetailNewsScreen({Key? key, required this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            height: size.height * 0.5,
            width: double.infinity,
            child: Hero(
              tag: news.imageUrl,
              child: Image.network(
                news.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
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
              height: size.height * 0.5,
              width: size.width,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                ),
              ], borderRadius: BorderRadius.circular(20), color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: "OpenSans",
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Đánh giá',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "OpenSans",
                          ),
                        ),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.red, size: 16),
                            Icon(Icons.star, color: Colors.red, size: 16),
                            Icon(Icons.star, color: Colors.red, size: 16),
                            Icon(Icons.star, color: Colors.red, size: 16),
                            Icon(Icons.star, color: Colors.grey, size: 16)
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      news.description,
                      softWrap: true,
                      style: const TextStyle(
                        color: Colors.black,
                        fontFamily: "OpenSans",
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Người viết : Trương Bá Vương",
                        style: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 13,
                            color: Colors.red,
                            fontWeight: FontWeight.normal),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
