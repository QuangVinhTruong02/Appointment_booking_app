import 'package:booking_doctor/common/entities/comment.dart';
import 'package:booking_doctor/common/entities/entities.dart';
import 'package:booking_doctor/common/utils/utils.dart';
import 'package:booking_doctor/common/widgets/shimmer_loading.dart';
import 'package:booking_doctor/common/widgets/widgets.dart';
import 'package:booking_doctor/pages/detail_question/controller.dart';
import 'package:booking_doctor/pages/detail_question/widget/comment_item.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/common/values/values.dart';

class DetailQuestionPage extends GetView<DetailQuestionController> {
  const DetailQuestionPage({super.key});

  // FocusNode inputFocusNode = FocusNode();

  // final controller = Get.find<DetailQuestionController>();

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppBar() {
      return CustomAppbar(
        title: Text(
          StringDetailQuestionValue.question,
          style: getMyTextStyle(
            fontSize: 20.sp,
            color: ColorsValue.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        isCenterTitle: true,
      );
    }

    Widget _buildInfo() {
      return Container(
        height: 60.h,
        padding: EdgeInsets.fromLTRB(15.w, 10.h, 10.w, 10.h),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: controller.state.question!.avatar,
              placeholder: (context, url) {
                return Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                );
              },
              imageBuilder: (context, imageProvider) {
                return Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(controller.state.question!.sexual,
                        style: getMyTextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    Text(
                      ", ${controller.state.question!.age} tuổi",
                      style: getMyTextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  dateFormat(controller.state.question!.createdAt.toDate()),
                  style: getMyTextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                )
              ],
            )
          ],
        ),
      );
    }

    Widget _buildAction() {
      return Container(
        height: 50.h,
        padding: EdgeInsets.only(left: 15.w),
        child: Row(
          children: [
            IconItem(
              controller.state.isLiked ? Icons.favorite : Icons.favorite_border,
              controller.state.isLiked ? Colors.red : Colors.black,
              () => controller.handleLikeQuestion(),
              size: 25.sp,
            ),
            SizedBox(width: 5.w),
            Text(
              controller.state.likesLength.toString(),
              style: getMyTextStyle(fontSize: 16.sp),
            ),
          ],
        ),
      );
    }

    Widget _buildImgs() {
      return SizedBox(
        height: 200.h,
        width: double.infinity,
        child: PageView.builder(
          padEnds: false,
          controller: PageController(viewportFraction: 0.8),
          scrollDirection: Axis.horizontal,
          itemCount: controller.state.question!.images?.length ?? 0,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(left: 15.w),
              child: CachedNetworkImage(
                imageUrl: controller.state.question!.images?[index],
                placeholder: (context, url) {
                  return Container(
                    width: 200.w,
                    height: 200.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                },
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: 200.w,
                    height: 200.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      );
    }

    Widget _buildLoading() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 10.w, top: 10.h),
            child: ShimmerLoading(
              height: 30.h,
              width: 100.w,
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 10.w),
            child: ShimmerLoading(
              height: 200.h,
              width: 350.w,
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
            ),
          ),
        ],
      );
    }

    Widget _buildContentQuestion() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 10.w),
            child: Text(
              controller.state.question!.title,
              style: getMyTextStyle(
                fontSize: 18.sp,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 10.w),
            child: Text(
              controller.state.question!.content,
              style: getMyTextStyle(
                fontSize: 16.sp,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      );
    }

    Widget _buildComment() {
      return Container(
        padding: EdgeInsets.only(bottom: 0.w, right: 10.w, left: 10.w),
        height: 60.h,
        width: 360.w,
        color: Colors.white,
        // padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          children: [
            Expanded(
              child: MyTextField(
                // focusNode: inputFocusNode,
                // onTap: () => controller.onTapComment(context),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                hint: "Nhập câu trả lời",
                controller: controller.state.replyController,
              ),
            ),
            SizedBox(width: 10.w),
            IconItem(
              Icons.send,
              ColorsValue.secondColor,
              () => controller.addCommentQuestion(),
            )
          ],
        ),
      );
    }

    Widget _buildBottomNavBar() {
      return Obx(
        () {
          return controller.state.isLoading
              ? SizedBox.shrink()
              : controller.isReply()
                  ? _buildComment()
                  : SizedBox.shrink();
        },
      );
    }

    Widget _buildReplier() {
      return Container(
        height: 60.h,
        margin: EdgeInsets.symmetric(horizontal: 10.w),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: ColorsValue.thirdColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(2.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedImageAvatar(
                avatarUrl: controller.state.question!.replierAvatar!, size: 40),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.state.question!.replierName!,
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

    Widget _buildCommentList() {
      return ListView.builder(
        shrinkWrap: true,
        reverse: true,
        physics: NeverScrollableScrollPhysics(),
        // controller: controller.state.scrollController,
        itemCount: controller.state.comments.length,
        itemBuilder: (context, index) {
          Comment comment = controller.state.comments[index];
          String name = "";
          String avatar = "";
          if (comment.role == Role.Doctor.displayRole) {
            name = controller.state.question!.replierName!;
            avatar = controller.state.question!.replierAvatar!;
          } else {
            name =
                "${controller.state.question!.sexual}, ${controller.state.question!.age} tuổi";
            avatar = controller.state.question!.avatar;
          }
          return commentItem(comment, name, avatar);
        },
      );
    }

    Widget _buildContent() {
      return GestureDetector(
        onTap: () {
          Get.focusScope?.unfocus();
        },
        child: Obx(
          () {
            return !controller.state.isLoading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: CustomScrollView(
                                controller: controller.state.scrollController,
                                // primary: true,
                                slivers: [
                                  SliverToBoxAdapter(
                                    child: _buildInfo(),
                                  ),
                                  SliverToBoxAdapter(
                                    child: _buildContentQuestion(),
                                  ),
                                  if (controller.state.question?.images != null)
                                    SliverToBoxAdapter(
                                      child: _buildImgs(),
                                    ),
                                  if (controller.state.question != null)
                                    SliverToBoxAdapter(
                                      child: _buildAction(),
                                    ),
                                  SliverToBoxAdapter(
                                    child: Divider(
                                      thickness: 1,
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                  SliverToBoxAdapter(child: _buildCommentList())
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      controller.isReply()
                          ? _buildComment()
                          : const SizedBox.shrink()
                    ],
                  )
                : _buildLoading();
          },
        ),
      );
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildContent(),
    );
  }
}
