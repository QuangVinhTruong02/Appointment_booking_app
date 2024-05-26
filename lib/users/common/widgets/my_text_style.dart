import 'dart:ui';
import 'package:flutter/material.dart';

TextStyle getMyTextStyle(
    {double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black}) {
  return TextStyle(
    fontFamily: 'Roboto',
    fontSize: fontSize,
    fontWeight: fontWeight,
    color: color,
  );
}
