import 'package:booking_doctor/common/values/string_manager.dart';
import 'package:booking_doctor/pages/group_question/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/common/values/colors_value.dart';
import 'package:booking_doctor/common/widgets/widgets.dart';
import 'package:booking_doctor/pages/application/controller.dart';
import 'package:booking_doctor/pages/home/index.dart';
import 'package:booking_doctor/pages/profile/index.dart';

class ApplicationPage extends GetView<ApplicationController> {
  ApplicationPage({super.key});

  List page = [
    HomePage(),
    GroupQuestionPage(),
    Center(child: Text("calendar")),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    Widget _buildBottomTabs() {
      return Obx(() {
        return SizedBox(
          width: 360.w,
          height: kBottomNavigationBarHeight.h,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            iconSize: 24.w,
            selectedItemColor: ColorsValue.secondColor,
            unselectedItemColor: Colors.grey,
            currentIndex: controller.state.pageIndex,
            selectedLabelStyle: getMyTextStyle(fontSize: 12.sp),
            unselectedLabelStyle: getMyTextStyle(fontSize: 12.sp),
            onTap: (value) {
              controller.handleNavBarTap(value);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: StringHomeValue.home_page,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.groups_outlined),
                label: StringHomeValue.group_chat,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined),
                label: StringHomeValue.calendar,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: StringHomeValue.person,
              ),
            ],
          ),
        );
      });
    }

    Widget _buildPageView() {
      return PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller.pageController,
          onPageChanged: (value) {
            controller.hanldeOnPageChanged(value);
          },
          children: [
            HomePage(),
            GroupQuestionPage(),
            Center(child: Text("calendar")),
            ProfilePage(),
          ]);
      // return Obx(
      //   () {
      //     return page[controller.state.pageIndex];
      //   },
      // );
    }

    return Scaffold(
      // extendBody: true,
      // extendBodyBehindAppBar: true,
      // resizeToAvoidBottomInset: false,
      backgroundColor: ColorsValue.primaryColor,
      bottomNavigationBar: _buildBottomTabs(),
      body: _buildPageView(),
    );
  }
}
