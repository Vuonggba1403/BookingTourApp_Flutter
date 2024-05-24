import 'package:flutter/material.dart';

class CommonWidgets {
  static Widget buildTextFormField({
    required TextEditingController controller,
    required String label,
    Widget? suffixIcon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w200,
              color: Colors.white),
        ),
        Container(
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white))),
          child: TextFormField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              suffixIconColor: Colors.white,
              border: InputBorder.none,
            ),
            obscureText: obscureText,
            validator: validator,
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
