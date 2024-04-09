import 'package:booking_doctor/common/values/string_manager.dart';
import 'package:booking_doctor/common/values/values.dart';
import 'package:booking_doctor/common/widgets/my_text_style.dart';
import 'package:booking_doctor/common/widgets/widgets.dart';
import 'package:booking_doctor/pages/home/widget/nav_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/common/values/colors_value.dart';
import 'package:booking_doctor/pages/home/controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  Widget _buildHeader() {
    return FittedBox(
      child: Container(
        height: kToolbarHeight + 100.h,
        width: 360.w,
        padding: EdgeInsets.only(
          left: 20.w,
          top: kToolbarHeight.w,
          right: 20.w,
        ),
        decoration: BoxDecoration(
          gradient: ColorsValue.linearPrimary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringHomeValue.title,
              style: getMyTextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 50.h,
              child: MyTextField(
                hint: StringHomeValue.search,
                controller: controller.state.searchController,
                readOnly: true,
                contentPadding: EdgeInsets.all(10.w),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildNav() {
    return Container(
      height: 100.h,
      width: 360.w,
      margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 2),
            spreadRadius: 2,
            blurRadius: 4,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          navItem(
            title: StringHomeValue.health_record,
            iconPath: AssetIconValue.heath_record,
            onTap: () {},
          ),
          navItem(
            title: StringHomeValue.calendar,
            iconPath: AssetIconValue.calendar,
            onTap: () {},
          ),
          navItem(
            title: StringHomeValue.group_chat,
            iconPath: AssetIconValue.group_chat,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorList() {
    return Container(
      width: 360.w,
      height: 350.h,
      color: Colors.blueGrey.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 10.w, top: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringHomeValue.doctor_list,
                  style: getMyTextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 0.05.sh,
                  // width: ,
                  child: getMyButton(
                    isBGColors: false,
                    radius: 8.r,
                    isBorderSide: true,
                    onPressed: () {},
                    child: Text(
                      "Xem thêm",
                      style: getMyTextStyle(fontSize: 12.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 10.w),
            child: Text(
              StringHomeValue.note_1,
              style:
                  getMyTextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            height: 250.h,
            width: 360.w,
            child: ListView.builder(
              // padEnds: false,
              // controller: controller.state.pageController,
              scrollDirection: Axis.horizontal,
              // physics: PageScrollPhysics(),
              itemCount: 20,
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  width: 150.w,
                  height: 250.w,
                  margin: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 3),
                        spreadRadius: 1,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: FittedBox(
                    child: Column(
                      children: [
                        Container(
                          height: 60.h,
                          width: 60.w,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                AssetImgValue.avt_default,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Bác sĩ $index",
                          style: getMyTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: ColorsValue.secondColor,
                              size: 15.sp,
                            ),
                            Text(
                              "5",
                              style: getMyTextStyle(fontSize: 12.sp),
                            )
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Container(
                          color: ColorsValue.thirdColor,
                          padding: EdgeInsets.symmetric(
                            vertical: 5.h,
                            horizontal: 10.w,
                          ),
                          child: Text(
                            "Chuyên khoa: Nội",
                            style: getMyTextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          "Bệnh viện ....................",
                          style: getMyTextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey.shade600,
                          ),
                          maxLines: 2,
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(
                          height: 30.w,
                          width: 100.w,
                          child: getMyButton(
                            radius: 8.r,
                            onPressed: () {},
                            child: Text(
                              StringHomeValue.advise,
                              style: getMyTextStyle(
                                fontSize: 14.sp,
                                color: Colors.white,
                              ),
                            ),
                            isBGColors: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // SliverLayoutBuilder(builder: (context, constraints) {
          //   return SliverAppBar(
          //     expandedHeight: 120.h,
          //     floating: false,
          //     pinned: true,
          //     flexibleSpace: _buildHeader(),
          //   );
          // }),
          SliverToBoxAdapter(
            child: _buildHeader(),
          ),
          SliverToBoxAdapter(
            child: _buildNav(),
          ),
          SliverPadding(padding: EdgeInsets.only(top: 20.h)),
          SliverToBoxAdapter(
            child: _buildDoctorList(),
          )
        ],
      ),
    );
  }
}
