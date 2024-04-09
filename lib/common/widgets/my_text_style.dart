import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle getMyTextStyle(
    {double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black}) {
  return TextStyle(
    fontFamily: 'Roboto',
    fontSize: fontSize.sp,
    fontWeight: fontWeight,
    color: color,
  );
}
