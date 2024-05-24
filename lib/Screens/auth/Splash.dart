import 'package:BookingTourApp/Screens/auth/Login.dart';
import 'package:BookingTourApp/data/contentsplash.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0); // Khởi tạo controller
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose(); // Giải phóng controller
    super.dispose();
  }

  void handleButtonPress() async {
    if (currentIndex == contents.length - 1) {
      // Hiển thị loading dialog
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: SpinKitThreeInOut(
            color: Colors.lightGreenAccent,
            size: 45.0,
          ),
        ),
      );

      await Future.delayed(const Duration(seconds: 1)); //time to wait

      // close
      if (context.mounted) {
        Navigator.pop(context);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const LoginScreen(),
          ),
        );
      }
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PageView.builder(
        itemCount: contents.length,
        controller: _controller,
        onPageChanged: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
        itemBuilder: (_, i) {
          return Container(
            color: contents[i].colorsplash,
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  const Text(
                    'Chào mừng đến với',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText(
                            'iVIVU',
                            textStyle: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Mali',
                              color: Colors.blue,
                            ),
                          ),
                        ],
                        repeatForever: true,
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          WavyAnimatedText(
                            '.COM',
                            textStyle: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'OpenSans',
                              color: Colors.white,
                            ),
                          ),
                        ],
                        repeatForever: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 320,
                    height: 320,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.black, width: 7),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        contents[i].image,
                        width: 300,
                        height: 300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    contents[i].discription,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      contents.length,
                      (index) => buildDot(index),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        minimumSize: const Size(150, 50),
                      ),
                      onPressed:
                          handleButtonPress, // Gọi hàm xử lý khi nhấn nút
                      child: Text(
                        currentIndex == contents.length - 1
                            ? "Bắt Đầu"
                            : "Tiếp Tục",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container buildDot(int index) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(right: 5),
    );
  }
}
