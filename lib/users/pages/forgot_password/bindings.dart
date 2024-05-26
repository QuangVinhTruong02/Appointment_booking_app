import 'package:get/get.dart';
import 'package:booking_doctor/users/pages/forgot_password/controller.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}
