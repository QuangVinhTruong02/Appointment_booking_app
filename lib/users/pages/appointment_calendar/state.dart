import 'package:booking_doctor/users/common/entities/doctor_schedule.dart';
import 'package:get/get.dart';

class AppointmentCalendarState {
  var _selectedDate = DateTime.now().obs;
  var _doctorSchedule = DoctorSchedule().obs;
  var _isLoading = true.obs;
  var _timeSlots = <TimeSlots>[].obs;
  var _availableTimeSlots = <TimeSlots>[].obs;
  var _selectedTimeSlot = Rx<TimeSlots?>(null);
  var _isHaveData = true.obs;

  set isLoading(bool value) => _isLoading.value = value;
  set selectedDate(DateTime value) => _selectedDate.value = value;
  set doctorSchedule(DoctorSchedule value) => _doctorSchedule.value = value;
  set timeSlots(List<TimeSlots> value) => _timeSlots.value = value;
  set selectedTimeSlot(TimeSlots? value) => _selectedTimeSlot.value = value;
  set availableTimeSlots(List<TimeSlots> value) =>
      _availableTimeSlots.value = value;
  set isHaveData(bool value) => _isHaveData.value = value;

  bool get isLoading => _isLoading.value;
  DateTime get selectedDate => _selectedDate.value;
  DoctorSchedule get doctorSchedule => _doctorSchedule.value;
  List<TimeSlots> get timeSlots => _timeSlots;
  TimeSlots? get selectedTimeSlot => _selectedTimeSlot.value;
  List<TimeSlots> get availableTimeSlots => _availableTimeSlots;
  bool get isHaveData => _isHaveData.value;
}
