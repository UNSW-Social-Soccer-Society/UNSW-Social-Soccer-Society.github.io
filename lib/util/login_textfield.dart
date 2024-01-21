import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final dynamic controller;
  final String hintText;
  final bool obscureText;
  final bool error;
  final bool numeric;

  const LoginTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.error,
    this.numeric = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        keyboardType: numeric ? TextInputType.number : TextInputType.text,
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: error ? Colors.red.shade600 : Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: error ? Colors.red.shade300 : Colors.grey)),
            fillColor: const Color.fromARGB(255, 255, 255, 255),
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400])),
      ),
    );
  }
}
