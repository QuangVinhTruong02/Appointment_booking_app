import 'dart:ui';

import 'package:flutter/material.dart';

class ColorsValue {
  static Color primaryColor = HexColor.fromHex("##F2F2F2");
  static Color secondColor = HexColor.fromHex("#05999E");
  static Color thirdColor = HexColor.fromHex("#CBE7E3");
  static Color buttonColor = HexColor.fromHex("#06B9BD");
  static LinearGradient linearPrimary = LinearGradient(colors: [
    secondColor,
    thirdColor,
  ]);
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll("#", "");
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString;
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
