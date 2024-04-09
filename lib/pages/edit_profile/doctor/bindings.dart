import 'package:booking_doctor/pages/edit_profile/doctor/controller.dart';
import 'package:get/get.dart';

class EditProfileDoctorBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileDoctorController>(
        () => EditProfileDoctorController());
  }
}
