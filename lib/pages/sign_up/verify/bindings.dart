import 'package:get/get.dart';
import 'package:booking_doctor/pages/sign_up/verify/index.dart';

class VerifyBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyController>(() => VerifyController());
  }
}
