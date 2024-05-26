import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';

Widget functionBar({
  required IconData leadingIcon,
  required String title,
  required endingIcon,
  required Function() onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
      // height: 50.h,
      // decoration: BoxDecoration(
      //     borderRadius: BorderRadius.all(Radius.circular(12.r)),
      //     color: Colors.white,
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.grey,
      //         blurRadius: 4,
      //         offset: Offset(0, 4),
      //       )
      //     ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(leadingIcon),
              SizedBox(width: 20.w),
              Text(
                title,
                style: getMyTextStyle(),
              ),
            ],
          ),
          Icon(endingIcon),
        ],
      ),
    ),
  );
}
