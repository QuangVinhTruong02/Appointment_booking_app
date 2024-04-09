import 'package:flutter/material.dart';
import 'package:booking_doctor/common/values/values.dart';

AppBar CustomAppbar({
  Widget? title,
  Widget? leading,
  List<Widget>? action,
  bool isCenterTitle = false,
}) {
  return AppBar(
    title: title,
    leading: leading,
    // backgroundColor: Colors.transparent,
    centerTitle: isCenterTitle,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        // color: ColorsValue.primaryColor,
        gradient: ColorsValue.linearPrimary,
      ),
    ),
    actions: action,
  );
}
