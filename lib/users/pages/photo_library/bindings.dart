import 'package:booking_doctor/users/pages/photo_library/index.dart';
import 'package:get/get.dart';

class PhotoLibraryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhotoLibraryController>(() => PhotoLibraryController());
  }
}
