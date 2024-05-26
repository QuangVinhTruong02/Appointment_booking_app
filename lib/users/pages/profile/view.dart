import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:booking_doctor/users/common/values/colors_value.dart';
import 'package:booking_doctor/users/common/values/string_manager.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:booking_doctor/users/pages/profile/index.dart';
import 'package:booking_doctor/users/pages/profile/widget/function_bar.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppbar() {
      return CustomAppBar(
        title: Text(
          StringValue.setting,
          style: getMyTextStyle(
            fontSize: 20.sp,
            color: ColorsValue.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        isCenterTitle: true,
      );
    }

    Widget _buildInf() {
      return Obx(() {
        return Container(
          width: 360.w,
          height: 180.h,
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: controller.userLoginResponse.photoUrl ?? "",
                imageBuilder: (context, imageProvider) {
                  return ClipOval(
                    child: Container(
                      height: 100.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
                placeholder: (context, url) {
                  return Container(
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                  );
                },
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 100.w,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                controller.userLoginResponse.userName ?? "",
                style: getMyTextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      });
    }

    Widget _buildAccountInf() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        // height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12.r),
            topRight: Radius.circular(12.r),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4,
              offset: Offset(0, 4),
            )
          ],
        ),
        child: Column(
          children: [
            //acount infomation
            functionBar(
              leadingIcon: Icons.person_outline,
              title: StringValue.account_infomation,
              endingIcon: Icons.arrow_forward_ios,
              onTap: controller.handleNavigationEdit,
            ),
            Divider(
              color: Colors.grey,
            ),
            //change password
            functionBar(
              leadingIcon: Icons.key,
              title: StringValue.change_password,
              endingIcon: Icons.arrow_forward_ios,
              onTap: () {},
            ),
            Divider(
              color: Colors.grey,
            ),
            functionBar(
              leadingIcon: Icons.logout,
              title: StringValue.log_out,
              endingIcon: Icons.arrow_forward_ios,
              onTap: () => controller.handleSignOut(context),
            ),
            Divider(
              color: Colors.grey,
            ),
          ],
        ),
      );
    }

    Widget _buildContent() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInf(),
          SizedBox(height: 30.h),
          Flexible(
            child: _buildAccountInf(),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: _buildAppbar(),
      body: _buildContent(),
    );
  }
}
