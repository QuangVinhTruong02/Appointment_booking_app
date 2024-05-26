import 'package:booking_doctor/users/common/entities/appointment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppointmentDoctorState {
  late TabController tabController;
  var _appointmentUpcomingList = <Appointment>[].obs;
  var _appointmentAllList = <Appointment>[].obs;
  var _refreshUpcomingController = RefreshController(initialRefresh: false).obs;
  var _refreshAllController = RefreshController(initialRefresh: false).obs;

  var _isLoading = true.obs;

  set isLoading(bool value) => _isLoading.value = value;
  set appointmentUpcomingList(List<Appointment> value) =>
      _appointmentUpcomingList.value = value;
  set appointmentAllList(List<Appointment> value) =>
      _appointmentAllList.value = value;

  List<Appointment> get appointmentUpcomingList => _appointmentUpcomingList;
  List<Appointment> get appointmentAllList => _appointmentAllList;
  RefreshController get refreshUpcomingController =>
      _refreshUpcomingController.value;
  bool get isLoading => _isLoading.value;
  RefreshController get refreshAllController => _refreshAllController.value;
}
