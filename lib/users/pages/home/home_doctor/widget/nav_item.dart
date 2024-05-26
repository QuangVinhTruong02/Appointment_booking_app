import 'package:booking_doctor/users/common/widgets/my_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget navItem({
  required String title,
  required String iconPath,
  // required bool isSelected,
  required Function() onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50.h,
          width: 50.w,
          child: Image.asset(
            iconPath,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 5.h),
        Text(
          title,
          style: getMyTextStyle(fontSize: 12.sp),
        ),
      ],
    ),
  );
}
