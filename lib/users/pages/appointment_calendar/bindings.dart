import 'package:booking_doctor/users/pages/appointment_calendar/controller.dart';
import 'package:get/get.dart';

class AppointmentCalendarBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentCalendarController>(
        () => AppointmentCalendarController());
  }
}
