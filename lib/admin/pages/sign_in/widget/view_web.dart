import 'package:booking_doctor/admin/common/values/asset_value_web.dart';
import 'package:booking_doctor/admin/common/values/colors_value_web.dart';
import 'package:booking_doctor/admin/media_query.dart';
import 'package:booking_doctor/admin/pages/sign_in/widget/form_login.dart';
import 'package:flutter/material.dart';

class SignInViewWeb extends StatelessWidget {
  const SignInViewWeb({super.key});

  @override
  Widget build(BuildContext context) {
    double titleSize = Responsive.isDesktop(context) ? 30 : 20;
    double contentSize = Responsive.isDesktop(context) ? 16 : 15;

    Widget _buildContent() {
      return Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 120, vertical: 90),
          padding: EdgeInsets.all(30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  height: 500,
                  width: 500,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AssetImgWebValue.signin_admin),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Container(
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(1, 2),
                            color: Colors.grey.shade300,
                            spreadRadius: 2,
                            blurRadius: 1,
                          )
                        ]),
                    child: FormLogin(
                        titleSize: titleSize, contentSize: contentSize),
                  ),
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
