import 'dart:io';

import 'package:booking_doctor/users/pages/edit_profile/patient/controller.dart';
import 'package:booking_doctor/users/pages/edit_profile/widget/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/users/common/values/colors_value.dart';
import 'package:booking_doctor/users/common/values/string_manager.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

class EditProfilePatientPage extends GetView<EditProfilePatientController> {
  const EditProfilePatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppbar() {
      return CustomAppBar(
        // leading: ,
        title: Text(
          StringValue.edit_profile,
          style: getMyTextStyle(
            fontSize: 20.sp,
            color: ColorsValue.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        isCenterTitle: true,
      );
    }

    Widget _buildAvt() {
      return Container(
        width: 360.w,
        child: Center(
          child: Stack(
            children: [
              ClipOval(
                child: Container(
                  height: 120.h,
                  width: 120.w,
                  color: Colors.grey[300],
                  child: FadeInImage(
                    placeholder: MemoryImage(kTransparentImage),
                    image: controller.isSelectedImgAss
                        ? FileImage(File(controller.state.photoUrl))
                        : NetworkImage(controller.state.photoUrl)
                            as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: CircleAvatar(
                    radius: 20.r,
                    backgroundColor: Colors.white,
                    child: IconItem(
                      Icons.camera_alt_outlined,
                      Colors.black,
                      () => showPickImageModal(context,
                          patientController: controller),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget _buildUserName() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringValue.userName_hint,
            style: getMyTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.h),
          MyTextField(
            icon: Icons.person_outline,
            hint: StringValue.userName_hint,
            controller: controller.state.userNameTextController,
            errorText: controller.userNameError.value.isEmpty
                ? null
                : controller.userNameError.value,
          ),
        ],
      );
    }

    Widget _buildDOB() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringProfileValue.DOB,
            style: getMyTextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          MyTextField(
            icon: Icons.calendar_month,
            hint: StringProfileValue.DOB,
            controller: controller.state.DOBController,
            readOnly: true,
            onTap: () {
              selectDate(context, controller);
            },
          )
        ],
      );
    }

    Widget _buildSexual() {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringProfileValue.sexual,
            style: getMyTextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Row(
                children: [
                  Radio(
                    fillColor:
                        MaterialStateProperty.all(ColorsValue.secondColor),
                    value: Sexual.Male,
                    groupValue: controller.state.sexual,
                    onChanged: (Sexual? sexual) {
                      controller.state.sexual = sexual;
                    },
                  ),
                  Text(StringProfileValue.male, style: getMyTextStyle()),
                ],
              ),
              SizedBox(width: 10.w),
              Row(
                children: [
                  Radio(
                    fillColor:
                        MaterialStateProperty.all(ColorsValue.secondColor),
                    value: Sexual.Female,
                    groupValue: controller.state.sexual,
                    onChanged: (Sexual? sexual) {
                      controller.state.sexual = sexual;
                    },
                  ),
                  Text(
                    StringProfileValue.female,
                    style: getMyTextStyle(),
                  ),
                ],
              ),
            ],
          )
        ],
      );
    }

    Widget _buildPhoneNumber() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringProfileValue.phone_number,
            style: getMyTextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          MyTextField(
            icon: Icons.phone_outlined,
            hint: StringProfileValue.phone_number,
            controller: controller.state.phoneNumberController,
            textInputType: TextInputType.number,
            errorText: controller.phoneNumberError.value.isEmpty
                ? null
                : controller.phoneNumberError.value,
          )
        ],
      );
    }

    Widget _buildSaveButton() {
      return SizedBox(
        height: 50.h,
        width: 360.w,
        child: getMyButton(
          isBGColors: true,
          onPressed: () {
            controller.isAllValid() ? controller.handleSave(context) : null;
          },
          child: Text(
            StringValue.save,
            style: getMyTextStyle(color: Colors.white, fontSize: 16.sp),
          ),
        ),
      );
    }

    Widget _buidContent() {
      return Obx(() {
        return controller.state.isLoading == false
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAvt(),
                  SizedBox(height: 20.h),
                  _buildUserName(),
                  SizedBox(height: 20.h),
                  _buildDOB(),
                  SizedBox(height: 20.h),
                  _buildSexual(),
                  SizedBox(height: 20.h),
                  _buildPhoneNumber(),
                  SizedBox(height: 20.h),
                  _buildSaveButton(),
                  SizedBox(height: 20.h),
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                  color: ColorsValue.secondColor,
                ),
              );
      });
    }

    return WillPopScope(
      onWillPop: () async {
        bool value =
            await showExitpageDialog(context, patientController: controller);
        return value;
      },
      child: Scaffold(
        backgroundColor: ColorsValue.primaryColor,
        appBar: _buildAppbar(),
        body: Padding(
          padding: EdgeInsets.only(top: 20.h, right: 20.w, left: 20.w),
          child: SingleChildScrollView(
            child: _buidContent(),
          ),
        ),
      ),
    );
  }
}
