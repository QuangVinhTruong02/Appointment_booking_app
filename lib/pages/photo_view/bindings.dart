import 'package:booking_doctor/pages/photo_view/controller.dart';
import 'package:get/get.dart';

class PhotoViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PhotoViewController>(() => PhotoViewController());
  }
}
