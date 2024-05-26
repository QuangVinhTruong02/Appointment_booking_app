import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/users/common/values/values.dart';
import 'package:booking_doctor/users/pages/sign_up/controller.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget _buildInputEmail() {
      return StreamBuilder<bool>(
          stream: controller.outputIsEmailValid,
          builder: (context, snapshot) {
            return MyTextField(
              hint: StringValue.email_hint,
              errorText:
                  (snapshot.data ?? true) ? null : StringError.email_error,
              icon: Icons.email,
              controller: controller.state.emailTextController,
            );
          });
    }

    Widget _buildInputUserName() {
      return StreamBuilder<bool>(
          stream: controller.outputIsUserNameValid,
          builder: (context, snapshot) {
            return MyTextField(
              hint: StringValue.userName_hint,
              icon: Icons.person,
              controller: controller.state.userNameTextController,
              errorText:
                  (snapshot.data ?? true) ? null : StringError.user_name_error,
            );
          });
    }

    Widget _buildInputPassword() {
      return StreamBuilder<bool>(
          stream: controller.outputIsPassword,
          builder: (context, snapshot) {
            return MyTextField(
              hint: StringValue.password_hint,
              icon: Icons.key,
              controller: controller.state.passwordTextController,
              obscure: true,
              errorText:
                  (snapshot.data ?? true) ? null : StringError.password_error,
            );
          });
    }

    Widget _buildInputConfirmPassword() {
      return StreamBuilder<bool>(
          stream: controller.outputIsConfirmPassword,
          builder: (context, snapshot) {
            return MyTextField(
              hint: StringValue.confirmPassword_hint,
              icon: Icons.key,
              controller: controller.state.confirmPasswordTextController,
              obscure: true,
              errorText: (snapshot.data ?? true)
                  ? null
                  : StringError.confirm_password_error,
            );
          });
    }

    Widget _buildButtonCreate() {
      return SizedBox(
        width: 320.w,
        height: 50.h,
        child: StreamBuilder<bool>(
            stream: controller.outputIsAllInputValid,
            builder: (context, snapshot) {
              return getMyButton(
                isBGColors: (snapshot.data ?? false),
                onPressed: (snapshot.data ?? false)
                    ? () async {
                        await controller.handleSignUp();
                      }
                    : null,
                child: Text(
                  '${StringValue.create}',
                  style: (snapshot.data ?? false)
                      ? getMyTextStyle(fontSize: 18.sp, color: Colors.white)
                      : getMyTextStyle(fontSize: 18.sp, color: Colors.grey),
                ),
              );
            }),
      );
    }

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
              padding: EdgeInsets.only(left: 20.w),
              decoration: BoxDecoration(gradient: ColorsValue.linearPrimary),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringValue.create_an_account,
                    style: getMyTextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
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
                  color: ColorsValue.primaryColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      StringValue.welcome,
                      style:
                          getMyTextStyle(fontSize: 16.sp, color: Colors.black),
                    ),
                    SizedBox(height: 20.h),
                    _buildInputEmail(),
                    //userName
                    SizedBox(height: 20.h),
                    _buildInputUserName(),
                    //password
                    SizedBox(height: 20.h),
                    _buildInputPassword(),
                    //confirmpassword
                    SizedBox(height: 20.h),
                    _buildInputConfirmPassword(),
                    //button sign up
                    Spacer(),
                    _buildButtonCreate(),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${StringValue.alreadyHaveAccount} ',
                          style: getMyTextStyle(fontSize: 16.sp),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.handleHaveAlreadyAccount();
                          },
                          child: Text(
                            StringValue.login,
                            style: getMyTextStyle(
                                fontSize: 16.sp,
                                color: ColorsValue.secondColor),
                          ),
                        )
                      ],
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
        // resizeToAvoidBottomInset: false,
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
