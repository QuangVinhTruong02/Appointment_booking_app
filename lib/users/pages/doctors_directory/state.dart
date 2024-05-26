import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorsDirectoryState {
  var _isOnTapSearchText = false.obs;
  var _doctors = <DoctorUser>[].obs;
  var _isLoading = true.obs;
  ScrollController scrollDoctorController = ScrollController();
  TextEditingController searchController = TextEditingController();

  set isOnTapSearchText(bool value) => _isOnTapSearchText.value = value;
  set doctors(List<DoctorUser> value) => _doctors.value = value;
  set isLoading(bool value) => _isLoading.value = value;

  bool get isOnTapSearchText => _isOnTapSearchText.value;
  List<DoctorUser> get doctors => _doctors;
  bool get isLoading => _isLoading.value;
}
