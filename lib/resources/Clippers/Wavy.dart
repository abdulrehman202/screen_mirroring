import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Wavy extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path0 = Path();
    path0.moveTo(0, size.height);
    path0.cubicTo(
        size.width * 0.0175000,
        size.height * 0.8700000,
        size.width * 0.1056250,
        size.height * 0.7960000,
        size.width * 0.1628125,
        size.height * 0.8025000);
    path0.cubicTo(
        size.width * 0.3731250,
        size.height * 0.8010000,
        size.width * 0.6365625,
        size.height * 0.7985000,
        size.width * 0.8356250,
        size.height * 0.7985000);
    path0.quadraticBezierTo(size.width * 0.9987500, size.height * 0.8005000,
        size.width, size.height * 0.5450000);
    path0.quadraticBezierTo(
        size.width, size.height * 0.9200000, size.width, size.height);
    path0.cubicTo(size.width * 0.7525000, size.height * 1.0060000,
        size.width * 0.7500000, size.height, 0, size.height);
    path0.close();

    return path0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
