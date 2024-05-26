import 'package:booking_doctor/users/common/widgets/my_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

// Future<bool?> toastInfo(
//     {required String msg,
//     Color backgroundColor = Colors.white,
//     Color textColor = Colors.black}) {
//   return Fluttertoast.showToast(
//     msg: msg,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.TOP,
//     backgroundColor: backgroundColor,
//     textColor: textColor,
//     fontSize: 16.sp,
//   );
// }

ToastificationItem toast({
  // required BuildContext context,
  required ToastificationType toastificationType,
  required String message,
}) {
  String title =
      toastificationType == ToastificationType.success ? 'SUCCESS' : 'ERROR';
  return toastification.show(
    // context: context,
    type: toastificationType,
    style: ToastificationStyle.fillColored,
    autoCloseDuration: const Duration(seconds: 3),
    title: Text(
      title,
      style: getMyTextStyle(
        fontSize: 18.sp,
        color: Colors.white,
      ),
    ),
    description: Text(
      message,
      style: getMyTextStyle(
        fontSize: 16.sp,
        color: Colors.white,
      ),
    ),
    alignment: Alignment.topCenter,
    showProgressBar: false,
  );
}
