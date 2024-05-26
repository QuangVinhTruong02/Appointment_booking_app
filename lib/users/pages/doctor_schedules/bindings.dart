import 'package:booking_doctor/users/pages/doctor_schedules/controller.dart';
import 'package:get/get.dart';

class WorkScheduleBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorScheduleController());
  }
}
