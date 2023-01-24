import 'dart:ui';

import 'package:flutter/material.dart';

class ColorManager {
  static Color black = HexColor.frontier('#25262c');
  static Color grey = HexColor.frontier('#434343');
  static Color lightGrey = HexColor.frontier('#5e5e5e');
  static Color white = HexColor.frontier('#ffffff');
}

class GradientManager {
  static const LinearGradient gradient = LinearGradient(
      colors: [
        Color(0xff62e5f3),
        Color(0xffac8dec),
        Color(0xfffebe9c),
        Color(0xfffff6ac),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      stops: [0.05, 0.35, 0.5, 1.0],
      tileMode: TileMode.clamp);

  static const LinearGradient buttonGradient = LinearGradient(
      colors: [
        Color(0xff62e5f3),
        Color(0xffac8dec),
        Color(0xfffebe9c),
        Color(0xfffff6ac),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      stops: [0.05, 0.35, 0.8, 1.0],
      tileMode: TileMode.clamp);

  static const LinearGradient yellowGradient = LinearGradient(
      colors: [
        Color(0xfff1e1a4),
        Color(0xffdeaa75),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp);

  static const LinearGradient pinkGradient = LinearGradient(
      colors: [
        Color(0xffff9af6),
        Color(0xffbe96f9),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp);

  static const LinearGradient blueGradient = LinearGradient(
      colors: [
        Color(0xffb7f8ff),
        Color(0xff4096d9),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.0, 1.0],
      tileMode: TileMode.clamp);
}

extension HexColor on Color {
  static Color frontier(String hexColorString) {
    hexColorString = hexColorString.replaceAll('#', '');

    if (hexColorString.length == 6) {
      hexColorString = 'FF$hexColorString';
    } //FF is concatenated if color does not have opacity

    return Color(int.parse(hexColorString, radix: 16));
  }
}
