import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:booking_doctor/users/common/values/values.dart';

Widget getMyButton({
  required bool isBGColors,
  required Function()? onPressed,
  required Widget child,
  double radius = 12,
  bool isBorderSide = false,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
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
          Radius.circular(radius.r),
        ),
      ),
      child: Center(child: child),
    ),
  );
}
