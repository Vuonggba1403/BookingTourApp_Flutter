import 'package:BookingTourApp/Themes/Colors.dart';
import 'package:BookingTourApp/data/Custom/showCustomDelightToastBar.dart';
import 'package:BookingTourApp/models/model_favorite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Future<void> deleteFavorite(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('favorites')
          .doc(docId)
          .delete();
      showCustomDelightToastBar(context, 'Xóa thành công!');
    } catch (e) {
      showCustomDelightToastBar(context, 'Có lỗi xảy ra, vui lòng thử lại!');
    }
  }

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
          ),
        ),
        title: const Text(
          'Yêu thích',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: primaryColor,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('favorites').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitDancingSquare(
                color: Colors.black,
                duration: Duration(seconds: 2),
                size: 45.0,
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final favoriteList = snapshot.data?.docs
                  .map((doc) => Favorite.fromFirestore(doc))
                  .toList() ??
              [];

          if (favoriteList.isEmpty) {
            return const Center(
              child: Text(
                'Chưa có sản phẩm yêu thích',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          return MasonryGridView.builder(
            itemCount: favoriteList.length,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              final favorite = favoriteList[index];
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: GestureDetector(
                  onLongPress: () => showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      titleTextStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      title: Text(
                        "Bạn muốn xoá ${favorite.name} khỏi yêu thích?",
                        textAlign: TextAlign.center,
                      ),
                      actions: [
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
                                  color: primaryColor,
                                  fontFamily: "OpenSans",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                deleteFavorite(favorite.docId);
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Chắc chắn",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: "OpenSans",
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    barrierDismissible: false,
                  ),
                  child: Stack(
                    children: [
                      Container(
                        height: 250 + (index % 3) * 50.0,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          image: DecorationImage(
                            image: NetworkImage(favorite.img),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          padding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          child: Text(
                            favorite.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
