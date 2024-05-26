import 'package:booking_doctor/admin/common/values/colors_value_web.dart';
import 'package:booking_doctor/admin/pages/sign_in/widget/form_login.dart';
import 'package:flutter/material.dart';

class SignInViewMobile extends StatelessWidget {
  const SignInViewMobile({super.key});

  @override
  Widget build(BuildContext context) {
    // Widget _buildForm() {
    //   return }

    Widget _buildContent() {
      return Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.all(30),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: FormLogin(titleSize: 18, contentSize: 16),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: ColorsValueWeb.primaryColor,
      body: SingleChildScrollView(
        child: _buildContent(),
      ),
    );
  }
}
