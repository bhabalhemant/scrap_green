import 'package:flutter/material.dart';

class AppTextStyle {
  static Function regular =
      (Color color, double size) => _style(color, size, FontWeight.w400);

  static Function light =
      (Color color, double size) => _style(color, size, FontWeight.w500);

  static Function bold =
      (Color color, double size) => _style(color, size, FontWeight.w700);

  static Function extrabold =
      (Color color, double size) => _style(color, size, FontWeight.w900);

  static TextStyle _style(Color color, double size, FontWeight fontWeight) {
    return _textStyle("OpenSans", color, size, fontWeight);
  }

  static TextStyle _textStyle(
      String fontFamily, Color color, double size, FontWeight fontWeight) {
    return TextStyle(
        fontFamily: fontFamily,
        color: color,
        fontSize: size,
        fontWeight: fontWeight);
  }
}
