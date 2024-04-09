import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/common/entities/entities.dart';

class HomeState {
  PageController pageController =
      PageController(viewportFraction: 0.45, initialPage: 0);
  TextEditingController searchController = TextEditingController();
  ScrollController scrollController = ScrollController();
  var isLoading = false.obs;
}
