import 'package:booking_doctor/users/common/entities/doctor.dart';
import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:get/get.dart';

class DoctorDetailState {
  var _doctor = DoctorUser().obs;
  var _isLoading = true.obs;
  var _descriptionWorkProgress = "".obs;

  set doctor(DoctorUser value) => _doctor.value = value;
  set isLoading(bool value) => _isLoading.value = value;
  set descriptionWorkProgress(String value) =>
      _descriptionWorkProgress.value = value;

  DoctorUser get doctor => _doctor.value;
  bool get isLoading => _isLoading.value;
  String get descriptionWorkProgress => _descriptionWorkProgress.value;
}
