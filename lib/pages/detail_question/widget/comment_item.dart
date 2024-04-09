import 'package:booking_doctor/common/entities/comment.dart';
import 'package:booking_doctor/common/entities/entities.dart';
import 'package:booking_doctor/common/utils/date.dart';
import 'package:booking_doctor/common/values/colors_value.dart';
import 'package:booking_doctor/common/widgets/cached_image_avatar.dart';
import 'package:booking_doctor/common/widgets/my_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

Widget commentItem(Comment comment, String name, String avatar) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 15.w),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: CachedImageAvatar(avatarUrl: avatar, size: 30.w),
        ),
        SizedBox(width: 10.w),
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 40.h,
            maxWidth: 250.w,
          ),
          child: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: ColorsValue.primaryColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.r),
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: getMyTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    // Text(
                    //   comment.content,
                    //   style: getMyTextStyle(
                    //     fontSize: 15.sp,
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    // ),
                    ReadMoreText(
                      textScaleFactor: 1.sp,
                      comment.content,
                      trimLines: 4,
                      trimMode: TrimMode.Line,
                      trimExpandedText: "Ẩn bớt",
                      trimCollapsedText: "Xem thêm",
                      style: getMyTextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      moreStyle: getMyTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                      lessStyle: getMyTextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey),
                    )
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  timeLineFormat(comment.createdAt.toDate()),
                  style: getMyTextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
