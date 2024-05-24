import 'dart:ui';
import 'package:BookingTourApp/Screens/PagescreenHome/profile_page.dart';
import 'package:BookingTourApp/Screens/auth/Forgotpassword.dart';
import 'package:BookingTourApp/Screens/auth/Register.dart';
import 'package:BookingTourApp/components/curve_navigation_bar.dart';
import 'package:BookingTourApp/components/animations.dart';
import 'package:BookingTourApp/data/Custom/loading_screen.dart';
import 'package:BookingTourApp/data/Custom/showCustomDelightToastBar.dart';
import 'package:BookingTourApp/data/Custom/textformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../data/bg_data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSecurePassword = true; //Biển theo dõi ẩn hiện pass

  int selectedIndex = 0;
  bool showOption = false;
  bool isLoading = false; // Biến để kiểm soát hiển thị loader
  //text
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //login method

  void login() async {
    // loading
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: SpinKitThreeInOut(
          color: Colors.lightGreenAccent,
          size: 45.0,
        ),
      ),
    );

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Navigator.pop(context);

      showCustomDelightToastBar(
        context,
        "Đăng nhập thành công",
      );
      loadingScreen(context, () => const CurveBar());
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      //truyen email
      Navigator.pushNamed(context, '/profile',
          arguments: _emailController.text);

      // check loi login
      if (e.code == 'user-not-found' && e.code == 'wrong-password') {
        showCustomDelightToastBar(
          context,
          "Sai thông tin đăng nhập",
        );
      } else if (!_formKey.currentState!.validate()) {
        showCustomDelightToastBar(
          context,
          "Vui lòng Nhập Đầy Đủ Thông Tin",
        );
      } else {
        showCustomDelightToastBar(
          context,
          "Sai Thông Tin !",
        );
      }
    }
  }

//giai phong bo nho
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 49,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
                child: showOption
                    ? ShowUpAnimation(
                        delay: 100,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: bgList.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: selectedIndex == index
                                      ? Colors.white
                                      : Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                        bgList[index],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    : const SizedBox()),
            const SizedBox(
              width: 20,
            ),
            showOption
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        showOption = false;
                      });
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30,
                    ))
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        showOption = true;
                      });
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(1),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(
                            bgList[selectedIndex],
                          ),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(bgList[selectedIndex]), fit: BoxFit.fill),
        ),
        alignment: Alignment.center,
        child: Container(
          height: MediaQuery.of(context).size.height *
              0.8, // set chieu cao cho khung container
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(15),
            color: Colors.black.withOpacity(0.1),
          ),
          child: Form(
            key: _formKey,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('iVIVU',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                )),
                            Text('.COM',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                  color: Colors.white,
                                )),
                          ],
                        ),
                        CommonWidgets.buildTextFormField(
                          controller: _emailController,
                          label: 'Email',
                          suffixIcon: const Icon(Icons.mail),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email không được để trống';
                            }
                            if (!value.contains('@gmail.com')) {
                              return 'Không đúng định dạng email';
                            }
                            return null; // Hợp lệ
                          },
                        ),
                        CommonWidgets.buildTextFormField(
                          controller: _passwordController,
                          label: 'Mật khẩu',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isSecurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                _isSecurePassword = !_isSecurePassword;
                              });
                            },
                          ),
                          obscureText: _isSecurePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Mật khẩu không được để trống';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text(
                              "Chưa có tài khoản ? ,",
                              style: TextStyle(
                                  fontFamily: "OpenSans", color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () {
                                loadingScreen(
                                    context, () => const RegisterScreen());
                              },
                              child: const Text('Đăng kí',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 220, 13, 41),
                                      fontFamily: 'OpenSans',
                                      // fontSize: 20,
                                      fontWeight: FontWeight.w200,
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          Color.fromARGB(255, 210, 27, 27))),
                            ),
                          ],
                        ),

                        //Forgot password

                        TextButton(
                            onPressed: () {
                              loadingScreen(
                                  context, () => ForgotPasswordPage());
                            },
                            child: const Text(
                              "Quên mật khẩu !",
                              style: TextStyle(
                                  color: Colors.white,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.white),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        //button login
                        GestureDetector(
                          onTap: () {
                            login();
                          },
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: const Center(
                                  child: Text(
                                "Đăng nhập",
                                style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 15,
                                    color: Colors.blue),
                              )),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Center(
                          child: Text('hoặc đăng nhập bằng',
                              style: TextStyle(
                                  // fontSize: 22,
                                  color: Colors.white,
                                  fontFamily: 'OpenSans')),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.mail),
                              color: Colors.red,
                              iconSize: 40,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.facebook),
                              color: Colors.blue,
                              iconSize: 40,
                            )
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
