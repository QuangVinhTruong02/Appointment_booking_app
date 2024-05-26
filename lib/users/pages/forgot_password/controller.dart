import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/users/common/values/string_manager.dart';
import 'package:booking_doctor/users/common/widgets/toast.dart';
import 'package:booking_doctor/users/pages/forgot_password/index.dart';
import 'package:toastification/toastification.dart';

class ForgotPasswordController extends GetxController {
  ForgotPasswordController();
  final state = ForgotPasswordState();
  final auth = FirebaseAuth.instance;

  Future sendRecoverEmail() async {
    await auth.sendPasswordResetEmail(
        email: state.emailTextController.text.trim());
    toast(
        toastificationType: ToastificationType.success,
        message: StringValue.please_check_your_email);
  }

  void handleBack() {
    Get.back();
  }
}
