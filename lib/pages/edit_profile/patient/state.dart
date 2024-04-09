import 'package:booking_doctor/pages/edit_profile/patient/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfilePatientState {
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController DOBController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  var _sexual = Rx<Sexual?>(null);
  var _photoUrl = "".obs;
  var _isLoading = true.obs;

  set photoUrl(String url) => _photoUrl.value = url;
  set sexual(Sexual? sexual) => _sexual.value = sexual;
  set isLoading(bool value) => _isLoading.value = value;

  String get photoUrl => _photoUrl.value;
  Sexual? get sexual => _sexual.value;
  bool get isLoading => _isLoading.value;
}
