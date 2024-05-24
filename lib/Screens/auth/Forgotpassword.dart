import 'package:BookingTourApp/Screens/auth/Login.dart';
import 'package:BookingTourApp/Themes/Colors.dart';
import 'package:BookingTourApp/data/Custom/loading_screen.dart';
import 'package:BookingTourApp/data/Custom/showCustomDelightToastBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '';
  bool _isEmailValid = true;
  String _resetPasswordError = '';

  //giai phong bo nho
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    setState(() {
      _isEmailValid = _formKey.currentState!.validate();
    });

    if (!_isEmailValid) {
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                "Thông Báo",
                textAlign: TextAlign.center,
              ),
              content: Text(
                "Đã gửi email đặt lại mật khẩu cho \n $_email.",
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    loadingScreen(context, () => const LoginScreen());
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showCustomDelightToastBar(
          context,
          "Email chưa được đăng ký",
        );
      } else {
        showCustomDelightToastBar(
          context,
          "Có lỗi xảy ra khi gửi email đặt lại mật khẩu.",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
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
            'Quên mật khẩu',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          backgroundColor: primaryColor,
        ),
        body: Center(
          child: Column(
            children: [
              Image.asset("assets/forgotpassword.gif"),
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Vui lòng nhập email của bạn để lấy lại mật khẩu !",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  //check email
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Email không được bỏ trống.';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Email không đúng định dạng.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _email = value.trim();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "abc@gmail.com",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide:
                          const BorderSide(color: Colors.green, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide:
                          const BorderSide(color: Colors.purple, width: 2.0),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  resetPassword();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(150, 50),
                  foregroundColor: Colors.white,
                  backgroundColor: secondaryColor,
                ),
                child: const Text("Gửi"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
