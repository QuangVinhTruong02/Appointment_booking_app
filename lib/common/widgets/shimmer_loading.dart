import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

Widget ShimmerLoading({
  required double height,
  required double width,
  required Color baseColor,
  required Color highlightColor,
  double radius = 10,
}) {
  return SizedBox(
    width: width.w,
    height: height.h,
    child: Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(radius.r),
          ),
        ),
      ),
    ),
  );
}
