import 'package:booking_doctor/users/common/entities/appointment.dart';
import 'package:booking_doctor/users/common/entities/doctor.dart';
import 'package:get/get.dart';

class AppointmentDetailState {
  var _appointment = Rx<Appointment?>(null);
  var _isLoading = true.obs;
  var _doctor = DoctorUser().obs;

  set doctor(DoctorUser value) => _doctor.value = value;
  set appointment(Appointment? value) => _appointment.value = value;
  set isLoading(bool value) => _isLoading.value = value;

  DoctorUser get doctor => _doctor.value;
  Appointment? get appointment => _appointment.value;
  bool get isLoading => _isLoading.value;
}
