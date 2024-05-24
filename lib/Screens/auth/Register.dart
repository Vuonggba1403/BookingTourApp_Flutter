import 'dart:ui';

import 'package:BookingTourApp/Screens/auth/Login.dart';
import 'package:BookingTourApp/components/animations.dart';
import 'package:BookingTourApp/data/Custom/loading_screen.dart';
import 'package:BookingTourApp/data/Custom/showCustomDelightToastBar.dart';
import 'package:BookingTourApp/data/Custom/textformfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../data/bg_data.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegistercreenState();
}

class _RegistercreenState extends State<RegisterScreen> {
  bool _isSecurePassword = true; //Biển theo dõi ẩn hiện pass
  bool _rememberPassword = false; //Checkbox
  int selectedIndex = 0;
  bool showOption = false;

  //text
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameuserController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  //register
  void registerUser() async {
    if (!_formKey.currentState!.validate()) {
      showCustomDelightToastBar(
        context,
        "Vui lòng điền đẩy đủ thông tin!",
      );
      return; // Exit if the form is not valid
    }

    // Loading
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
      // New account creation
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Save user details in Firestore
      User? user = userCredential.user;
      if (user != null) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': _nameuserController.text,
          'email': _emailController.text,
          'password': _passwordController.text,
        });
      }

      Navigator.pop(context); // Close loading dialog

      // Register success
      showCustomDelightToastBar(
        context,
        "Đăng ký thành công!",
      );
      loadingScreen(context, () => const LoginScreen());
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Close loading dialog
      // Check email duplication
      if (e.code == 'email-already-in-use') {
        showCustomDelightToastBar(
          context,
          "Tài khoản đã tồn tại!",
        );
      } else {
        showCustomDelightToastBar(
          context,
          "Đăng ký thất bại: ${e.message}",
        );
      }
    } catch (e) {
      Navigator.pop(context); // Close loading dialog
      showCustomDelightToastBar(
        context,
        "Đăng ký thất bại: ${e.toString()}",
      );
    }
  }

  //giai phong bo nho
  @override
  void dispose() {
    _emailController.dispose();
    _nameuserController.dispose();
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
              0.9, // set chieu cao cho khung container
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
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            loadingScreen(context, () => const LoginScreen());
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Color.fromARGB(255, 144, 143, 143),
                          ),
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('iVIVU',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'OpenSans',
                                  color: Colors.blue,
                                )),
                            Text('.COM',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'OpenSans',
                                  color: Colors.white,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CommonWidgets.buildTextFormField(
                          controller: _nameuserController,
                          label: 'Tên đăng nhập',
                          suffixIcon: const Icon(Icons.supervised_user_circle),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tên đăng nhập không được để trống';
                            }
                            return null;
                          },
                        ),
                        CommonWidgets.buildTextFormField(
                          controller: _emailController,
                          label: 'Email',
                          suffixIcon: const Icon(Icons.mail),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email không được để trống';
                            }
                            if (!value.contains('@')) {
                              return 'Email phải chứa ký tự "@"';
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
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () {
                            registerUser();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: const Center(
                                child: Text(
                              "Đăng Ký Ngay",
                              style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 15,
                                  color: Colors.blue),
                            )),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Row(
                              children: [
                                Text(
                                  'Đã có tài khoản?',
                                  style: TextStyle(
                                      // fontSize: 20,
                                      fontFamily: 'OpenSans',
                                      color: Colors.white),
                                )
                              ],
                            ),
                            TextButton(
                                onPressed: () {
                                  loadingScreen(
                                    context,
                                    () => const LoginScreen(),
                                  );
                                },
                                child: const Text(
                                  'Đăng nhập',
                                  style: TextStyle(
                                      // fontSize: 23,
                                      fontFamily: 'OpenSans',
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.red,
                                      color: Colors.red),
                                ))
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
