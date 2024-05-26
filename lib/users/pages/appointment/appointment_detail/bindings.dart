import 'package:booking_doctor/users/pages/appointment/appointment_detail/controller.dart';
import 'package:get/get.dart';

class AppointmentDetailBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentDetailController>(
        () => AppointmentDetailController());
  }
}
