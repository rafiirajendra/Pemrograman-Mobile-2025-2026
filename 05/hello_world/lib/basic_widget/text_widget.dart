import 'package:flutter/material.dart';

class MyTextWidget extends StatelessWidget {
  const MyTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Nama saya Rafi, sedang belajar Pemrograman Mobile",
      style: TextStyle(fontSize: 14, color: Colors.red),
      textAlign: TextAlign.center
    );
  }
}