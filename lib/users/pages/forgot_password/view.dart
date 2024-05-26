import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:booking_doctor/users/common/values/values.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:booking_doctor/users/pages/forgot_password/index.dart';

class ForgotPasswordPage extends GetView<ForgotPasswordController> {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      return SizedBox(
        height: 720.h,
        width: 360.w,
        child: Stack(
          children: [
            //register
            Container(
              height: 150.h,
              width: double.infinity,
              padding: EdgeInsets.only(left: 20.w, top: 50.h),
              decoration: BoxDecoration(gradient: ColorsValue.linearPrimary),
              child: Text(
                StringValue.forgor_password,
                style: getMyTextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
            Positioned(
              top: 120.h,
              child: Container(
                height: 600.h,
                width: 360.w,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                    color: ColorsValue.primaryColor),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 200.h,
                      width: 200.w,
                      child: Lottie.asset(AssetJsonValue.forgot_password),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      StringValue.forgor_password,
                      style: getMyTextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      StringValue.enter_email_to_get_password,
                      style:
                          getMyTextStyle(fontSize: 16.sp, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    MyTextField(
                      hint: StringValue.email_hint,
                      icon: Icons.email,
                      controller: controller.state.emailTextController,
                    ),
                    // Spacer(),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 50.h,
                      width: 360.w,
                      child: getMyButton(
                        isBGColors: true,
                        onPressed: controller.sendRecoverEmail,
                        child: Text(
                          StringValue.send,
                          style: getMyTextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    GestureDetector(
                      onTap: controller.handleBack,
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back,
                            color: ColorsValue.secondColor,
                          ),
                          Text(
                            StringValue.back,
                            style: getMyTextStyle(
                              fontSize: 16.sp,
                              color: ColorsValue.secondColor,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => _buildContent(),
            childCount: 1,
          ),
        )
      ],
    ));
  }
}
