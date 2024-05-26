import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:booking_doctor/users/common/store/store.dart';
import 'package:booking_doctor/users/common/utils/date.dart';
import 'package:booking_doctor/users/common/values/values.dart';
import 'package:booking_doctor/users/common/widgets/cached_image_avatar.dart';
import 'package:booking_doctor/users/common/widgets/icon_item.dart';
import 'package:booking_doctor/users/common/widgets/my_text_style.dart';
import 'package:booking_doctor/users/pages/group_question/controller.dart';
// import 'package:booking_doctor/pages/group_question/all_question/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Item extends StatefulWidget {
  final Question item;
  Item({super.key, required this.item});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  bool isLiked = false;
  int likedLength = 0;
  final controller = Get.find<GroupQuestionController>();

  @override
  void initState() {
    super.initState();
    isLiked = widget.item.likes.contains(UserStore.to.token);
    likedLength = widget.item.likes.length;
  }

  @override
  Widget build(BuildContext context) {
    return _buildItem();
  }

  Widget _buildAction() {
    return Row(
      children: [
        IconItem(
          isLiked ? Icons.favorite : Icons.favorite_outline,
          isLiked ? Colors.red : Colors.black,
          () {
            controller.handleLikeQuestion(widget.item);
            setState(() {
              isLiked = !isLiked;
              if (isLiked)
                likedLength++;
              else
                likedLength--;
            });
          },
          size: 25.sp,
        ),
        SizedBox(width: 5.w),
        Text(
          likedLength.toString(),
          style: getMyTextStyle(fontSize: 16.sp),
        ),
        SizedBox(width: 20.w),
        IconItem(
          Icons.comment_outlined,
          Colors.black,
          () => null,
          size: 25.sp,
        ),
        SizedBox(
          width: 5.w,
        ),
        Text(
          widget.item.commentLength.toString(),
          style: getMyTextStyle(fontSize: 16.sp),
        ),
      ],
    );
  }

  Widget _buildInfo() {
    return Row(
      children: [
        CachedImageAvatar(avatarUrl: widget.item.avatar, size: 50),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  widget.item.sexual,
                  style: getMyTextStyle(
                      fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
                Text(
                  ", ${widget.item.age} tuổi",
                  style: getMyTextStyle(
                      fontSize: 16.sp, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Text(
              formatDate(widget.item.createdAt.toDate()),
              style: getMyTextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _buildReplier() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: ColorsValue.thirdColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(2.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedImageAvatar(avatarUrl: widget.item.replierAvatar!, size: 40),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.item.replierName!,
                style: getMyTextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "Đã trả lời câu hỏi",
                style: getMyTextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItem() {
    return GestureDetector(
      onTap: () =>
          controller.handleNextPageDetailQuestion(widget.item.questionId),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.h),
        padding: EdgeInsets.fromLTRB(15.w, 10.h, 10.w, 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(1, 2),
              blurRadius: 2,
              spreadRadius: 1,
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfo(),
            SizedBox(height: 10.h),
            Text(
              widget.item.title,
              style: getMyTextStyle(
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10.h),
            Text(
              widget.item.content,
              style: getMyTextStyle(
                fontSize: 16.sp,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
              maxLines: 8,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10.h),
            if (widget.item.replierAvatar != null) _buildReplier(),
            SizedBox(height: 10.h),
            _buildAction(),
          ],
        ),
      ),
    );
  }
}
