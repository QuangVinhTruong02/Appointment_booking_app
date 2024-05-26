import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/users/common/values/values.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:booking_doctor/users/pages/sign_up/verify/index.dart';
import 'package:lottie/lottie.dart';

class VerifyPage extends GetView<VerifyController> {
  const VerifyPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller;
    Widget _buildImg() {
      return SizedBox(
        width: 150.w,
        height: 150.h,
        child: Lottie.asset(AssetJsonValue.sending_email),
      );
    }

    Widget _buildContent() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          //register
          Container(
            height: 120.h,
            padding: EdgeInsets.only(left: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  StringValue.verify_your_account,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Flexible(
            child: Container(
              height: 600.h,
              width: 360.w,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                color: ColorsValue.primaryColor,
              ),
              child: Column(
                children: [
                  _buildImg(),
                  SizedBox(height: 10.h),
                  Text(
                    StringValue.check_your_email,
                    style: getMyTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    StringValue.sent_a_verification,
                    style: getMyTextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.email!,
                    style: getMyTextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
                    width: 360.w,
                    height: 50.h,
                    child: getMyButton(
                      isBGColors: true,
                      onPressed: () => controller.sendEmailVerification(),
                      child: Text(
                        StringValue.resend_email,
                        style: getMyTextStyle(
                            fontSize: 18.sp, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      );
    }

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          height: 720.w,
          width: 360.w,
          padding: EdgeInsets.only(top: 20.h),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorsValue.secondColor,
                ColorsValue.thirdColor,
              ],
            ),
          ),
          child: _buildContent(),
        ),
      ),
    );
  }
}
