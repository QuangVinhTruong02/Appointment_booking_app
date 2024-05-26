import 'package:booking_doctor/users/pages/doctor_schedules/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HealthRecordFormState {
  TextEditingController nameController = TextEditingController();
  TextEditingController DOBController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController IDCardController = TextEditingController();
  var _checkboxObjGender = <CheckBoxObject>[].obs;

  set checkboxObjGender(List<CheckBoxObject> value) =>
      _checkboxObjGender.value = value;
  List<CheckBoxObject> get checkboxObjGender => _checkboxObjGender;
}
