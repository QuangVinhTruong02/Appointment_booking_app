import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:get/get.dart';

class DoctorScheduleState {
  var _toDay = DateTime.now().obs;
  var _listWorkingDay = <CheckBoxObject>[].obs;
  var _listWorkingTime = <CheckBoxObject>[].obs;
  var _doctorSchedule = DoctorSchedule().obs;
  var _isLoading = true.obs;
  var _timeSlots = <TimeSlots>[].obs;

  set toDay(DateTime value) {
    _toDay.value = value;
  }

  set listWorkingDay(List<CheckBoxObject> value) =>
      _listWorkingDay.value = value;
  set listWorkingTime(List<CheckBoxObject> value) =>
      _listWorkingTime.value = value;
  set doctorSchedule(DoctorSchedule value) => _doctorSchedule.value = value;
  set isLoading(bool value) => _isLoading.value = value;
  set timeSlots(List<TimeSlots> value) => _timeSlots.value = value;

  DateTime get toDay => _toDay.value;
  List<CheckBoxObject> get listWorkingDay => _listWorkingDay;
  List<CheckBoxObject> get listWorkingTime => _listWorkingTime;
  DoctorSchedule get doctorSchedule => _doctorSchedule.value;
  bool get isLoading => _isLoading.value;
  List<TimeSlots> get timeSlots => _timeSlots;
}

class CheckBoxObject {
  String name;
  bool value;
  CheckBoxObject({required this.name, required this.value});
}
