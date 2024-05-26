import 'package:booking_doctor/admin/common/values/colors_value_web.dart';
import 'package:booking_doctor/admin/common/widgets/text_style_for_web.dart';
import 'package:booking_doctor/users/common/values/string_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showDialogFormWeb(BuildContext context, Widget child) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return Center(
        child: SingleChildScrollView(
          child: Container(
            width: 1000,
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: child,
          ),
        ),
      );
    },
  );
}

void showLoadingDialogWeb(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          // height: 200.h,
          width: 250,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: ColorsValueWeb.primaryColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Material(
            color: ColorsValueWeb.primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  StringValue.processing,
                  style: TextStyleWeb(fontSize: 16),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(
                  color: ColorsValueWeb.secondColor,
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
