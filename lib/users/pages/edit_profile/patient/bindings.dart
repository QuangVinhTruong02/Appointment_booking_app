import 'package:booking_doctor/users/pages/edit_profile/patient/controller.dart';
import 'package:get/get.dart';

class EditProfilePatientBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfilePatientController>(
        () => EditProfilePatientController());
  }
}
