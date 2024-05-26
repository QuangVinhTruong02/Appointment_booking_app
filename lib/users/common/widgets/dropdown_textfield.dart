import 'package:booking_doctor/users/common/values/colors_value.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDropDownTextField extends StatelessWidget {
  final String hint;
  final SingleValueDropDownController controller;
  final List<DropDownValueModel> dropDownList;
  final bool isEnabled;
  const MyDropDownTextField({
    super.key,
    required this.hint,
    required this.controller,
    required this.dropDownList,
    this.isEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return DropDownTextField(
      isEnabled: isEnabled,
      readOnly: true,
      textStyle: getMyTextStyle(fontSize: 16.sp),
      controller: controller,
      listTextStyle: getMyTextStyle(fontSize: 16.sp),
      onChanged: (value) {},
      textFieldDecoration: InputDecoration(
        hintText: hint,
        hintStyle: getMyTextStyle(
            fontSize: 16.sp,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w500),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade500, width: 1.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorsValue.secondColor, width: 1.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
      ),
      dropDownItemCount: 4,
      dropDownList: dropDownList,
    );
  }
}
