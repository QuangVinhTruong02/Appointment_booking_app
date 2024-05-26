import 'package:get/get.dart';
import 'package:booking_doctor/users/pages/sign_in/controller.dart';

class SignInBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(() => SignInController());
  }
}
