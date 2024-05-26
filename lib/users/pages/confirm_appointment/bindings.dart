import 'package:booking_doctor/users/pages/confirm_appointment/controller.dart';
import 'package:get/get.dart';

class ConfirmAppointmentBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmAppointmentController>(
        () => ConfirmAppointmentController());
  }
}
