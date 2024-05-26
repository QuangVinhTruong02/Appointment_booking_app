import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:booking_doctor/users/common/values/values.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          // height: 200.h,
          width: 250.w,
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.w),
          decoration: BoxDecoration(
            color: ColorsValue.primaryColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Material(
            color: ColorsValue.primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  StringValue.processing,
                  style: getMyTextStyle(fontSize: 18.sp),
                ),
                SizedBox(height: 20.h),
                CircularProgressIndicator(
                  color: ColorsValue.secondColor,
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showQuestionDialog(
    {required BuildContext context,
    required String title,
    required String? lottieAsset,
    required Function()? onTapSubmit,
    required Function()? onTapCancel}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          child: Container(
            width: 250.w,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
            decoration: BoxDecoration(
              color: ColorsValue.primaryColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (lottieAsset != null)
                  SizedBox(
                    height: 100.h,
                    width: 100.w,
                    child: Lottie.asset(
                      lottieAsset,
                      fit: BoxFit.cover,
                    ),
                  ),
                SizedBox(height: 10.h),
                Text(
                  title,
                  style: getMyTextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 5.w),
                        child: getMyButton(
                          isBGColors: false,
                          onPressed: onTapCancel,
                          child: Text(
                            StringContentDia.cancel,
                            style: getMyTextStyle(
                                fontSize: 16.sp, color: Colors.black),
                          ),
                          isBorderSide: true,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 5.w),
                        child: getMyButton(
                          isBGColors: true,
                          onPressed: onTapSubmit,
                          child: Text(
                            StringContentDia.accept,
                            style: getMyTextStyle(
                                fontSize: 16.sp, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showErrorDialog({
  required BuildContext context,
  required String content,
}) {
  dismissDialog(context);
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          // height: 300.h,
          width: 250.w,
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Material(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 100.h,
                  width: 100.w,
                  child: Lottie.asset(
                    AssetJsonValue.warning,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  content,
                  style: getMyTextStyle(fontSize: 16.sp),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  height: 40.h,
                  width: 120.w,
                  child: getMyButton(
                    isBGColors: true,
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      StringValue.cancel,
                      style: getMyTextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void dismissDialog(BuildContext context) {
  if (_isThereCurrentDialogShowing(context)) {
    Get.back();
  }
}

_isThereCurrentDialogShowing(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent != true;
