import 'package:booking_doctor/users/pages/doctors_directory/index.dart';
import 'package:get/get.dart';

class DoctorsDirectoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DoctorsDirectoryController>(() => DoctorsDirectoryController());
  }
}
