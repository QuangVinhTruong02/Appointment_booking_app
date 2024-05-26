import 'package:booking_doctor/users/common/entities/appointment.dart';
import 'package:booking_doctor/users/common/entities/doctor.dart';
import 'package:get/get.dart';

class HomeDoctorState {
  var _appointments = <Appointment>[].obs;
  var _isAppointmentOverviewLoading = true.obs;
  var _isDoctorLoading = true.obs;
  var _totalAppointmentsSuccess = 0.obs;
  var _totalAppointmentsWaiting = 0.obs;
  var _totalAppointmentsCancel = 0.obs;
  var _doctor = DoctorUser().obs;

  set appointments(List<Appointment> value) => _appointments.value = value;
  set isAppointmentOverviewLoading(bool value) =>
      _isAppointmentOverviewLoading.value = value;
  set totalAppointmentsSuccess(int value) =>
      _totalAppointmentsSuccess.value = value;
  set totalAppointmentsWaiting(int value) =>
      _totalAppointmentsWaiting.value = value;
  set totalAppointmentsCancel(int value) =>
      _totalAppointmentsCancel.value = value;
  set doctor(DoctorUser value) => _doctor.value = value;
  set isDoctorLoading(bool value) => _isDoctorLoading.value = value;

  List<Appointment> get appointments => _appointments;
  bool get isAppointmentOverviewLoading => _isAppointmentOverviewLoading.value;
  int get totalAppointmentsSuccess => _totalAppointmentsSuccess.value;
  int get totalAppointmentsWaiting => _totalAppointmentsWaiting.value;
  int get totalAppointmentsCancel => _totalAppointmentsCancel.value;
  DoctorUser get doctor => _doctor.value;
  bool get isDoctorLoading => _isDoctorLoading.value;
}
