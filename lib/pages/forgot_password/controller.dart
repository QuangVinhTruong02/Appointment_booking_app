import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/common/values/string_manager.dart';
import 'package:booking_doctor/common/widgets/toast.dart';
import 'package:booking_doctor/pages/forgot_password/index.dart';

class ForgotPasswordController extends GetxController {
  ForgotPasswordController();
  final state = ForgotPasswordState();
  final auth = FirebaseAuth.instance;

  Future sendRecoverEmail() async {
    await auth.sendPasswordResetEmail(
        email: state.emailTextController.text.trim());
    toastInfo(msg: StringValue.please_check_your_email);
  }

  void handleBack() {
    Get.back();
  }
}
