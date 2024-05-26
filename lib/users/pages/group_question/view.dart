import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:booking_doctor/users/common/utils/enum_extension.dart';
import 'package:booking_doctor/users/common/widgets/shimmer_loading.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:booking_doctor/users/pages/group_question/index.dart';
import 'package:booking_doctor/users/pages/group_question/widget/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/users/common/values/values.dart';
import 'package:booking_doctor/users/common/store/store.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GroupQuestionPage extends StatefulWidget {
  GroupQuestionPage({super.key});

  @override
  State<GroupQuestionPage> createState() => _GroupQuestionPageState();
}

class _GroupQuestionPageState extends State<GroupQuestionPage> {
  final controller = Get.find<GroupQuestionController>();

  @override
  void dispose() {
    controller.onRefresh();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppBar() {
      return CustomAppBar(
        title: Text(
          StringGroupQAValue.group_q_a,
          style: getMyTextStyle(
            fontSize: 20.sp,
            color: ColorsValue.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        isCenterTitle: true,
      );
    }

    Widget _buildSearchForQuestion() {
      return Container(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.w),
        height: 60.h,
        width: double.infinity,
        child: Obx(() {
          return TextField(
            onTap: () {
              controller.state.isOnTapSearchText = true;
            },
            onTapOutside: (event) => controller.onTapOutSide(),
            onEditingComplete: () {
              controller.filterQuestions();
              Get.focusScope!.unfocus();
            },
            style: getMyTextStyle(fontSize: 16.sp),
            controller: controller.state.searchController,
            decoration: InputDecoration(
              hintText: "Nhập nội dung tìm kiếm",
              hintStyle:
                  getMyTextStyle(fontSize: 16.sp, color: Colors.grey.shade400),
              prefixIcon: Icon(
                Icons.search,
                color: ColorsValue.secondColor,
              ),
              suffixIcon: controller.state.isOnTapSearchText
                  ? IconItem(Icons.close, Colors.grey,
                      () => controller.onTapCloseButton(),
                      size: 20.sp)
                  : null,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 5.h, horizontal: 2.w),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          );
        }),
      );
    }

    Widget _buildLoading() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10.h),
        height: 250.h,
        width: 360.w,
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Positioned.fill(
              child: ShimmerLoading(
                height: 250.h,
                width: 360.w,
                baseColor: Colors.grey.shade100,
                highlightColor: Colors.grey.shade50,
              ),
            ),
            Positioned.fill(
              child: FittedBox(
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerLoading(
                          height: 30.h,
                          width: 100.w,
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100),
                      SizedBox(height: 20.h),
                      ShimmerLoading(
                          height: 180.h,
                          width: 360.w,
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        // child: FadeLoading(height: 100, width: 100),
      );
    }

    Widget _buildQuestions() {
      return Obx(
        () {
          if (controller.state.filterQuestionList.isEmpty &&
              controller.state.isLoading) {
            return ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return _buildLoading();
              },
            );
          } else if (controller.state.filterQuestionList.isNotEmpty) {
            return ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: SmartRefresher(
                // enablePullUp: true,
                enablePullDown: true,
                controller: controller.state.refreshController,
                header: const WaterDropHeader(),
                onRefresh: controller.onRefresh,
                child: ListView.builder(
                  controller: controller.state.scrollController,
                  // shrinkWrap: true,
                  itemCount: controller.state.filterQuestionList.length,
                  itemBuilder: (context, index) {
                    if (index < controller.state.filterQuestionList.length) {
                      Question item =
                          controller.state.filterQuestionList[index];
                      return Item(item: item);
                    } else {
                      return controller.state.isLoading
                          ? _buildLoading()
                          : null;
                    }
                  },
                ),
              ),
            );
          } else {
            return Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Không có kết quả nào được tìm thấy",
                  style: getMyTextStyle(
                    fontSize: 16.sp,
                    color: Colors.grey,
                  ),
                )
              ],
            );
          }
        },
      );
    }

    Widget _buildContent() {
      return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: _buildSearchForQuestion(),
            )
          ];
        },
        body: _buildQuestions(),
      );
    }

    Widget _buildFloatingActionButton() {
      return UserStore.to.userLoginResponse.role == Role.Patient.displayRole
          ? FloatingActionButton(
              onPressed: () => controller.handleNavigateCreateQuestion(),
              backgroundColor: ColorsValue.secondColor,
              shape: ShapeBorder.lerp(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                1,
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : const SizedBox.shrink();
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildContent(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }
}
