import 'package:booking_doctor/admin/common/widgets/my_button_web.dart';
import 'package:booking_doctor/admin/common/widgets/text_style_for_web.dart';
import 'package:booking_doctor/admin/common/widgets/textfield_web.dart';
import 'package:booking_doctor/admin/common/widgets/widgets.dart';
import 'package:booking_doctor/admin/pages/sign_in/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FormLogin extends StatefulWidget {
  final double titleSize;
  final double contentSize;
  FormLogin({super.key, required this.titleSize, required this.contentSize});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  @override
  void initState() {
    super.initState();
    Provider.of<SignInWebController>(context, listen: false)
        .bindTextController();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignInWebController>(
      builder: (context, controller, child) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chào mừng trở lại",
            style: TextStyleWeb(
              fontSize: widget.titleSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Vui lòng điền email và mật khẩu của bạn để đăng nhập vào trang Admin",
            style: TextStyleWeb(
              fontSize: widget.contentSize,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 10),
          if (controller.state.errorMess.isNotEmpty)
            Container(
              // margin: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              padding: EdgeInsets.all(8),
              margin: EdgeInsets.zero,
              color: Colors.red.shade100,
              child: Text(
                controller.state.errorMess,
                style: TextStyleWeb(
                  fontSize: widget.contentSize,
                  fontWeight: FontWeight.normal,
                  color: Colors.red.shade400,
                ),
              ),
            ),
          SizedBox(height: 30),
          Text(
            "Email",
            style: TextStyleWeb(
              fontSize: widget.contentSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          MyTextFieldWeb(
            hint: "Nhập địa chỉ email",
            controller: controller.state.emailTextEditingController,
            fontSize: widget.contentSize,
          ),
          SizedBox(height: 10),
          Text(
            "Mật khẩu",
            style: TextStyleWeb(
              fontSize: widget.contentSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          MyTextFieldPasswordWeb(
            hint: "Nhập mật khẩu",
            controller: controller.state.passwordTextEditingController,
            fontSize: widget.contentSize,
          ),
          SizedBox(height: 20),
          // Spacer(),
          SizedBox(
            height: 50,
            child: MybuttonWeb(
              isBGColors: controller.state.isValidInput ? true : false,
              onPressed: controller.state.isValidInput
                  ? () => controller.signIn(context)
                  : () {},
              child: Text(
                "Đăng nhập",
                style: TextStyleWeb(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: controller.state.isValidInput
                      ? Colors.white
                      : Colors.grey,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
