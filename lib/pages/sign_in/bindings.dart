import 'package:get/get.dart';
import 'package:booking_doctor/pages/sign_in/controller.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
