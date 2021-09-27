import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String? hintText;
  final bool obscureText;
  final TextEditingController controller;
  MyTextField(
      {@required this.hintText,
      required this.obscureText,
      required this.controller});

  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.red,
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
