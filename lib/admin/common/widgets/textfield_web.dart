import 'package:booking_doctor/admin/common/widgets/text_style_for_web.dart';
import 'package:booking_doctor/users/common/values/values.dart';
import 'package:flutter/material.dart';

class MyTextFieldWeb extends StatelessWidget {
  String hint;
  String? errorText;
  IconData? icon;
  TextEditingController controller;
  double fontSize;
  Function()? onTap;
  Function(String)? onSubmitted;
  EdgeInsets? contentPadding;
  bool? readOnly;
  MyTextFieldWeb({
    super.key,
    required this.hint,
    this.errorText,
    this.icon,
    required this.controller,
    required this.fontSize,
    this.onTap,
    this.contentPadding,
    this.onSubmitted,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly ?? false,
      onTap: onTap,
      onSubmitted: onSubmitted,
      style: TextStyleWeb(fontSize: fontSize, fontWeight: FontWeight.w500),
      cursorColor: ColorsValue.secondColor,
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: contentPadding,
        // prefixIcon: icon != null
        //     ? Icon(
        //         icon,
        //         color: ColorsValue.secondColor,
        //       )
        //     : null,
        suffixIcon: icon != null
            ? Icon(
                icon,
                color: ColorsValue.secondColor,
              )
            : null,
        hintText: hint,
        hintStyle: TextStyleWeb(
            fontSize: fontSize,
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
        errorText: errorText,
      ),
    );
  }
}

class MyTextFieldPasswordWeb extends StatefulWidget {
  String hint;
  String? errorText;
  IconData? icon;
  TextEditingController controller;
  double fontSize;
  Function()? onTap;
  EdgeInsets? contentPadding;
  MyTextFieldPasswordWeb({
    super.key,
    required this.hint,
    this.errorText,
    this.icon,
    required this.controller,
    required this.fontSize,
    this.onTap,
    this.contentPadding,
  });

  @override
  State<MyTextFieldPasswordWeb> createState() => _MyTextFieldPasswordWebState();
}

class _MyTextFieldPasswordWebState extends State<MyTextFieldPasswordWeb> {
  bool _isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      // scrollPadding: EdgeInsets.only(bottom: 150.w),
      onTap: widget.onTap,

      style:
          TextStyleWeb(fontSize: widget.fontSize, fontWeight: FontWeight.w500),
      cursorColor: ColorsValue.secondColor,
      controller: widget.controller,
      obscureText: (!_isVisible ? true : false),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        contentPadding: widget.contentPadding,
        prefixIcon: widget.icon != null
            ? Icon(
                widget.icon,
                color: ColorsValue.secondColor,
              )
            : null,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _isVisible = !_isVisible;
            });
          },
          icon: !_isVisible
              ? Icon(
                  Icons.visibility_off,
                  color: ColorsValue.secondColor,
                )
              : Icon(
                  Icons.visibility,
                  color: ColorsValue.secondColor,
                ),
        ),
        hintText: widget.hint,
        hintStyle: TextStyleWeb(
            fontSize: widget.fontSize,
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
