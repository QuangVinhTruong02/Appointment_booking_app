import 'package:booking_doctor/users/common/entities/appointment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentPatientState {
  late TabController tabController;
  var _appointmentWaitingList = <Appointment>[].obs;
  var _appointmentCancelList = <Appointment>[].obs;
  var _appointmentCompletedList = <Appointment>[].obs;
  var _isLoading = true.obs;

  set appointmentWaitingList(List<Appointment> value) =>
      _appointmentWaitingList.value = value;
  set appointmentCancelList(List<Appointment> value) =>
      _appointmentCancelList.value = value;
  set appointmentCompletedList(List<Appointment> value) =>
      _appointmentCompletedList.value = value;
  set isLoading(bool value) => _isLoading.value = value;

  List<Appointment> get appointmentWaitingList => _appointmentWaitingList;
  List<Appointment> get appointmentCancelList => _appointmentCancelList;
  List<Appointment> get appointmentCompletedList => _appointmentCompletedList;
  bool get isLoading => _isLoading.value;
}
