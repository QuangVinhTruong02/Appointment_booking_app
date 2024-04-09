import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/common/entities/entities.dart';

import 'package:booking_doctor/pages/home/index.dart';

class HomeController extends GetxController {
  HomeController();
  HomeState state = HomeState();

  @override
  void dispose() {
    state.searchController.dispose();
    super.dispose();
  }
}
