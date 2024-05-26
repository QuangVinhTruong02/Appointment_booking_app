import 'package:get/get.dart';
import 'package:booking_doctor/users/pages/sign_up/controller.dart';

class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }
}
