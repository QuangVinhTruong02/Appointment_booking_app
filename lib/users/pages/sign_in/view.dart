import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/users/common/values/values.dart';
import 'package:booking_doctor/users/pages/sign_in/controller.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';

class SignInPage extends GetView<SignInController> {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget _buildInputEmail() {
      return StreamBuilder<bool>(
        stream: controller.outputIsEmailValid,
        builder: (context, snapshot) {
          return MyTextField(
            hint: StringValue.email_hint,
            errorText: (snapshot.data ?? true) ? null : StringError.email_error,
            icon: Icons.email,
            controller: controller.state.emailTextController,
          );
        },
      );
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
        },
      );
    }

    Widget _buildButtonSignIn() {
      return SizedBox(
        width: 320.w,
        height: 50.h,
        child: StreamBuilder<bool>(
            stream: controller.outputIsAllInputValid,
            builder: (context, snapshot) {
              return getMyButton(
                isBGColors: snapshot.data ?? false,
                onPressed: (snapshot.data ?? false)
                    ? () {
                        controller.handleSignIn(context);
                      }
                    : null,
                child: Text(
                  '${StringValue.login}',
                  style: (snapshot.data ?? false)
                      ? getMyTextStyle(fontSize: 18.sp, color: Colors.white)
                      : getMyTextStyle(fontSize: 18.sp, color: Colors.grey),
                ),
              );
            }),
      );
    }

    Widget _buildButtonSignInWithGoogle() {
      return SizedBox(
        height: 50.h,
        child: getMyButton(
            isBGColors: false,
            onPressed: () => controller.handleSignInWithGoogle(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetImgValue.google_logo,
                  width: 20.w,
                  height: 20.h,
                ),
                Text(
                  ' ${StringValue.sign_in_google}',
                  style: getMyTextStyle(fontSize: 16.sp),
                ),
              ],
            ),
            isBorderSide: true),
      );
    }

    Widget _buildInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringValue.welcome_back,
            style: getMyTextStyle(fontSize: 16.sp, color: Colors.black),
          ),
          SizedBox(height: 20.h),
          //email
          _buildInputEmail(),
          //password
          SizedBox(height: 20.h),
          _buildInputPassword(),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  controller.handleForgotPassword();
                },
                //Forgot password
                child: Text(
                  StringValue.forgor_password,
                  style: getMyTextStyle(
                      fontSize: 16.sp, color: ColorsValue.secondColor),
                ),
              ),
            ],
          ),
          //button sign up
          SizedBox(height: 20.h),
          _buildButtonSignIn(),
          SizedBox(height: 20.h),
          // Spacer(),
          //Divide or with login
          SizedBox(
            height: 20.h,
            width: 360.w,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 70.w,
                  child: const Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ),
                const Spacer(),
                Text(
                  StringValue.or_continue_with,
                  style: getMyTextStyle(fontSize: 16.sp),
                ),
                const Spacer(),
                SizedBox(
                  width: 70.w,
                  child: const Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          //button Sign in with google
          SizedBox(height: 20.h),
          _buildButtonSignInWithGoogle(),
          SizedBox(height: 30.h),
          //don't have account
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${StringValue.dontHaveAccount} ',
                style: getMyTextStyle(fontSize: 16.sp),
              ),
              GestureDetector(
                onTap: () {
                  controller.handleDontHaveAccount();
                },
                child: Text(
                  StringValue.sign_up,
                  style: getMyTextStyle(
                      fontSize: 16.sp, color: ColorsValue.secondColor),
                ),
              )
            ],
          ),
        ],
      );
    }

    Widget _buildContent() {
      return SizedBox(
        height: 720.h,
        width: 360.w,
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //register
            Container(
              height: 150.h,
              width: double.infinity,
              decoration: BoxDecoration(gradient: ColorsValue.linearPrimary),
              padding: EdgeInsets.only(left: 20.w, top: 50.w),
              child: Text(
                StringValue.login,
                style: getMyTextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                  color: ColorsValue.primaryColor,
                ),
                child: _buildInput(),
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _buildContent(),
          ),
        ],
      ),
    );
  }
}
