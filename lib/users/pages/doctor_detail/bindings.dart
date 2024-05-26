import 'package:booking_doctor/users/pages/doctor_detail/controller.dart';
import 'package:get/get.dart';

class DoctorDetailBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorDetailController>(() => DoctorDetailController());
  }
}
