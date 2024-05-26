import 'dart:async';

import 'package:booking_doctor/users/common/widgets/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/users/common/routes/routes.dart';
import 'package:booking_doctor/users/common/utils/utils.dart';
import 'package:booking_doctor/users/common/values/values.dart';
import 'package:toastification/toastification.dart';

class VerifyController extends GetxController {
  VerifyController();

  @override
  void onInit() {
    super.onInit();
    sendEmailVerification();
    setTimerAutoRedicrect();
  }

  Future sendEmailVerification() async {
    try {
      await FirebaseAuth.instance.currentUser!
          .sendEmailVerification()
          .then((_) {
        toast(
            toastificationType: ToastificationType.success,
            message: StringValue.please_check_your_email);
      });
    } on FirebaseAuthException catch (e) {
      var result = AuthExceptionHandle.handleException(e);
      toast(
        toastificationType: ToastificationType.error,
        message: AuthExceptionHandle.generateExceptionMessage(result),
      );
    }
  }

  void setTimerAutoRedicrect() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser!.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.toNamed(AppRoutes.APPLICATION);
      }
    });
  }
}
