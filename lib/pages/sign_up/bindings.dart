import 'package:get/get.dart';
import 'package:booking_doctor/pages/sign_up/controller.dart';

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
