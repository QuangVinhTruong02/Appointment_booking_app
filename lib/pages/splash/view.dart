import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/common/routes/routes.dart';
import 'package:booking_doctor/common/store/store.dart';
import 'package:booking_doctor/common/values/values.dart';
import 'package:booking_doctor/common/widgets/widgets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      if (UserStore.to.isLogin == true) {
        Get.offNamed(AppRoutes.APPLICATION);
      } else {
        final user = FirebaseAuth.instance.currentUser ?? null;
        if (user != null && !user.emailVerified) {
          Get.offNamed(AppRoutes.VERIFY);
        }
        Get.offNamed(AppRoutes.SIGN_IN);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: ColorsValue.linearPrimary,
        ),
        child: Center(
          child: Text(
            StringValue.welcomeTitle,
            style: getMyTextStyle(
              fontSize: 40.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
