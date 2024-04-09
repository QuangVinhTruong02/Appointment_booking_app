import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/common/routes/routes.dart';
import 'package:booking_doctor/common/utils/utils.dart';
import 'package:booking_doctor/common/values/values.dart';
import 'package:booking_doctor/common/widgets/widgets.dart';

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
        toastInfo(msg: StringValue.please_check_your_email);
      });
    } on FirebaseAuthException catch (e) {
      var result = AuthExceptionHandle.handleException(e);
      toastInfo(msg: AuthExceptionHandle.generateExceptionMessage(result));
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
