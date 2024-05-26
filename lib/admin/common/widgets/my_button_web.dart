import 'package:flutter/material.dart';
import 'package:booking_doctor/users/common/values/values.dart';

Widget MybuttonWeb({
  required bool isBGColors,
  required Function()? onPressed,
  required Widget child,
  double radius = 8,
  bool isBorderSide = false,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        // gradient: backgroundColor != null ? backgroundColor : null,
        color: !isBGColors ? Colors.white : ColorsValue.buttonColor,
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Colors.grey,
            offset: Offset(0, 2),
          ),
        ],
        border:
            isBorderSide ? Border.all(color: ColorsValue.buttonColor) : null,
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
      ),
      child: Center(child: child),
    ),
  );
}
