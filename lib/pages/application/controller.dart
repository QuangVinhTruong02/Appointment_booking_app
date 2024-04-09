import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/pages/application/index.dart';

class ApplicationController extends GetxController {
  ApplicationState state = ApplicationState();
  late final List<BottomNavigationBarItem> bottomTabs;
  late final PageController pageController;
  late final List<String> tabTitles;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: state.pageIndex);
    tabTitles = ['home', 'search', 'post', 'mess', 'person'];
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  // void handleNavigatorToCreatePost() => Get.toNamed(AppRoutes.CREATE_POST);

  void handleNavBarTap(int value) {
    pageController.jumpToPage(
      value,
      // duration: Duration(milliseconds: 500),
      // curve: Curves.bounceInOut,
    );

    // state.pageIndex = value;
  }

  void hanldeOnPageChanged(int value) {
    state.pageIndex = value;
  }
}
