import 'package:booking_doctor/users/common/entities/doctor.dart';
import 'package:booking_doctor/users/common/entities/health_record.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmAppointmentState {
  var _selectedDate = DateTime.now().obs;
  var _selectedTime = "".obs;
  var _timeSlotId = "".obs;
  var _doctorScheduleId = "".obs;
  var _doctor = DoctorUser().obs;
  var _healthRecord = Rx<HealthRecord?>(null);
  var _healthRecords = <HealthRecord>[].obs;
  TextEditingController symptomTextController = TextEditingController();
  var _isLoadingHealthRecord = true.obs;

  set selectedDate(DateTime value) => _selectedDate.value = value;
  set doctor(DoctorUser value) => _doctor.value = value;
  set selectedTime(String value) => _selectedTime.value = value;
  set timeSlotId(String value) => _timeSlotId.value = value;
  set doctorScheduleId(String value) => _doctorScheduleId.value = value;
  set healthRecord(HealthRecord? value) => _healthRecord.value = value;
  set healthRecords(List<HealthRecord> value) => _healthRecords.value = value;
  set isLoadingHealthRecord(bool value) => _isLoadingHealthRecord.value = value;

  DateTime get selectedDate => _selectedDate.value;
  DoctorUser get doctor => _doctor.value;
  String get selectedTime => _selectedTime.value;
  String get timeSlotId => _timeSlotId.value;
  String get doctorScheduleId => _doctorScheduleId.value;
  HealthRecord? get healthRecord => _healthRecord.value;
  List<HealthRecord> get healthRecords => _healthRecords;
  bool get isLoadingHealthRecord => _isLoadingHealthRecord.value;
}
