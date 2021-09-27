import 'package:flutter/material.dart';
import 'colors.dart' as colors;

TextStyle _textStyle(Color color, double size, FontWeight fontWeight,
    TextDecoration textDecoration) {
  return TextStyle(
    fontFamily: 'Poppins',
    color: color,
    fontWeight: fontWeight,
    decoration: textDecoration,
  );
}

class AppTextStyle {
  static TextStyle medium60PrimaryWhite() =>
      _textStyle(colors.White, 60, FontWeight.w400, TextDecoration.none);

  static TextStyle medium80PrimaryWhite() =>
      _textStyle(colors.White, 200, FontWeight.w500, TextDecoration.none);

  static TextStyle light20primaryGrey() =>
      _textStyle(colors.Black, 50, FontWeight.w400, TextDecoration.none);

  static TextStyle light40primaryWhite() =>
      _textStyle(colors.White, 40, FontWeight.w300, TextDecoration.none);

  static TextStyle light40italicWhite() =>
      _textStyle(colors.White, 40, FontWeight.w300, TextDecoration.none);
}
