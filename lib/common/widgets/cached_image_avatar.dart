import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget CachedImageAvatar({required String avatarUrl, required double size}) {
  return CachedNetworkImage(
    imageUrl: avatarUrl,
    placeholder: (context, url) {
      return Container(
        width: size.w,
        height: size.h,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          shape: BoxShape.circle,
        ),
      );
    },
    imageBuilder: (context, imageProvider) {
      return Container(
        width: size.w,
        height: size.h,
        // padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fitHeight,
          ),
        ),
      );
    },
  );
}
