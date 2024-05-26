import 'package:booking_doctor/admin/pages/sign_in/widget/view_mobile.dart';
import 'package:booking_doctor/admin/pages/sign_in/widget/view_web.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SignInWeb extends StatelessWidget {
  const SignInWeb({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(SignInWebController());
    return ScreenTypeLayout.builder(
      desktop: (p0) => SignInViewWeb(),
      mobile: (p0) => SignInViewMobile(),
    );
  }
}
