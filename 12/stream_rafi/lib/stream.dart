import 'package:flutter/material.dart';

class ColorStream {
  final List<Color> colors = [
    Colors.pink,
    Colors.deepOrange,
    Colors.yellowAccent,
    Colors.lightGreenAccent,
    Colors.lightBlueAccent,
    Colors.deepPurple,
  ];

  Stream<Color> getColors() async* {
    yield* Stream.periodic(
      const Duration(seconds: 1), (int t) {
        int index = t % colors.length;
        return colors[index];
    });
  }
}