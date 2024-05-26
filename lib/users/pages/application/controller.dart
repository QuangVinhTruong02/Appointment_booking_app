import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/users/pages/application/index.dart';

class ApplicationController extends GetxController {
  ApplicationState state = ApplicationState();
  late final List<BottomNavigationBarItem> bottomTabs;
  late final PageController pageController;
  late final List<String> tabTitles;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: state.pageIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void handleNavBarTap(int value) {
    pageController.jumpToPage(
      value,
    );
  }

  void hanldeOnPageChanged(int value) {
    state.pageIndex = value;
  }
}
