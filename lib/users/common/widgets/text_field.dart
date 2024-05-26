import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:booking_doctor/users/common/values/values.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';

// ignore: must_be_immutable
class MyTextField extends StatefulWidget {
  String hint;
  String? errorText;
  IconData? icon;
  TextEditingController controller;
  bool? obscure;
  bool? readOnly;
  TextInputType? textInputType;
  Function()? onTap;
  EdgeInsets? contentPadding;
  bool? isNumberPhone;
  // FocusNode? focusNode;
  MyTextField({
    super.key,
    required this.hint,
    this.errorText,
    this.icon,
    required this.controller,
    this.obscure,
    this.textInputType,
    this.readOnly,
    this.onTap,
    this.contentPadding,
    this.isNumberPhone,
    // this.focusNode,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      // maxLength: widget.isNumberPhone == true ? 10 : null,
      // focusNode: widget.focusNode,
      // autofocus: true,
      // scrollPadding: EdgeInsets.only(bottom: 150.w),
      onTap: widget.onTap,

      readOnly: widget.readOnly ?? false,
      keyboardType: widget.textInputType,
      inputFormatters: [
        if (widget.textInputType == TextInputType.number ||
            widget.isNumberPhone == true)
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        if (widget.isNumberPhone == true) LengthLimitingTextInputFormatter(9),
      ],
      style: getMyTextStyle(fontSize: 16.sp),
      cursorColor: ColorsValue.secondColor,
      controller: widget.controller,
      obscureText:
          widget.obscure != null ? (!_isVisible ? true : false) : false,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: widget.contentPadding,
        // prefix: widget.isNumberPhone == true
        //     ? Text(
        //         "+84 ",
        //         style: getMyTextStyle(
        //           fontSize: 16.sp,
        //           color: Colors.black,
        //         ),
        //       )
        //     : null,
        // prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        prefixIcon: widget.icon != null
            ? Icon(
                widget.icon,
                color: ColorsValue.secondColor,
              )
            : widget.isNumberPhone == true
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "+84 ",
                        style: getMyTextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )
                : null,
        suffixIcon: widget.obscure != null
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _isVisible = !_isVisible;
                  });
                },
                icon: _isVisible
                    ? Icon(
                        Icons.visibility_off,
                        color: ColorsValue.secondColor,
                      )
                    : Icon(
                        Icons.visibility,
                        color: ColorsValue.secondColor,
                      ),
              )
            : null,
        hintText: widget.hint,
        hintStyle: getMyTextStyle(
            fontSize: 16.sp,
            color: Colors.grey.shade400,
            fontWeight: FontWeight.w500),
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
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        errorText: widget.errorText,
      ),
    );
  }
}
