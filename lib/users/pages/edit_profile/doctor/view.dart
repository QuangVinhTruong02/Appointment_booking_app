import 'dart:io';

import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:booking_doctor/users/pages/edit_profile/doctor/controller.dart';
import 'package:booking_doctor/users/pages/edit_profile/doctor/widget/show_dialog.dart';
import 'package:booking_doctor/users/pages/edit_profile/widget/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/users/common/values/colors_value.dart';
import 'package:booking_doctor/users/common/values/string_manager.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class EditProfileDoctorPage extends GetView<EditProfileDoctorController> {
  const EditProfileDoctorPage({super.key});

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
        margin: EdgeInsets.only(top: 10.h),
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
                          doctorController: controller),
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

    Widget _buildWorkPlace() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringProfileValue.work_place,
            style: getMyTextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          MyTextField(
            icon: Icons.place_outlined,
            hint: StringProfileValue.work_place,
            controller: controller.state.workPlaceController,
          )
        ],
      );
    }

    Widget _buildMajor() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            StringProfileValue.major,
            style: getMyTextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.h),
          MyTextField(
            icon: Icons.work_outline,
            hint: StringProfileValue.major,
            controller: controller.state.majorController,
          )
        ],
      );
    }

    Widget _buildWorkExperience() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                StringProfileValue.work_experience,
                style: getMyTextStyle(
                    fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              IconItem(
                Icons.add,
                ColorsValue.secondColor,
                () {
                  showAddWorkExperienceDialog(context, controller);
                },
              ),
            ],
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.state.workExperienceList.length,
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemBuilder: (context, index) {
              String item = controller.state.workExperienceList[index];
              return Slidable(
                key: Key('$item'),
                endActionPane: ActionPane(
                  extentRatio: 0.2,
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.close,
                      onPressed: (context) {
                        controller.state.removeWorkExperience(index);
                      },
                    )
                  ],
                ),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                  width: 360.w,
                  child: Text(
                    "- ${item}",
                    style: getMyTextStyle(fontSize: 16.sp),
                  ),
                ),
              );
            },
          ),
        ],
      );
    }

    Widget _buildWorkProgress() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                StringProfileValue.work_progress,
                style: getMyTextStyle(
                    fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              IconItem(
                Icons.add,
                ColorsValue.secondColor,
                () {
                  controller.state.fromYearWorkProgressController.clear();
                  controller.state.toYearWorkProgressController.clear();
                  controller.state.workAtController.clear();
                  showAddWorkProgressDialog(context, controller);
                },
              ),
            ],
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.state.workProgressList.length,
            itemBuilder: (context, index) {
              WorkProgress item = controller.state.workProgressList[index];
              return Slidable(
                key: Key('$item'),
                endActionPane: ActionPane(
                  extentRatio: 0.5,
                  motion: const ScrollMotion(),
                  children: [
                    SlidableAction(
                      flex: 1,
                      backgroundColor: ColorsValue.secondColor,
                      foregroundColor: Colors.white,
                      icon: Icons.edit_outlined,
                      onPressed: (context) {
                        //TODO: chỉnh sửa lại
                        // controller.EditWorkProgress(context, index);
                      },
                    ),
                    SlidableAction(
                      flex: 1,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete_outlined,
                      onPressed: (context) {
                        controller.state.removeWorkProgress(index);
                      },
                    ),
                  ],
                ),
                child: SizedBox(
                  width: 360.w,
                  child: ListTile(
                    minVerticalPadding: 0.h,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    minLeadingWidth: 10.w,
                    leading: Icon(
                      Icons.circle,
                      size: 10.r,
                    ),
                    title: Text(
                      //TODO: Chỉnh sửa lại
                      // "${item.fromYear} - ${item.toYear}",
                      "",
                      style: getMyTextStyle(fontSize: 16.sp),
                    ),
                    subtitle: Text(
                      "${item.workAt}",
                      style:
                          getMyTextStyle(fontSize: 14.sp, color: Colors.grey),
                    ),
                  ),
                ),
              );
            },
          ),
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
            style: getMyTextStyle(color: Colors.white, fontSize: 18.sp),
          ),
        ),
      );
    }

    Widget _buidContent() {
      return Obx(
        () {
          return !controller.state.isLoading
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAvt(),
                    SizedBox(height: 20.h),
                    _buildUserName(),
                    SizedBox(height: 20.h),
                    _buildWorkPlace(),
                    SizedBox(height: 20.h),
                    _buildMajor(),
                    SizedBox(height: 20.h),
                    _buildWorkExperience(),
                    SizedBox(height: 20.h),
                    _buildWorkProgress(),
                    SizedBox(height: 20.h),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: ColorsValue.secondColor,
                  ),
                );
        },
      );
    }

    return WillPopScope(
      onWillPop: () async {
        bool value =
            await showExitpageDialog(context, doctorController: controller);
        return value;
        // return true;
      },
      child: Scaffold(
        backgroundColor: ColorsValue.primaryColor,
        appBar: _buildAppbar(),
        body: Container(
          width: 360.w,
          height: 720.h,
          padding: EdgeInsets.only(right: 20.w, left: 20.w),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: _buidContent(),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: _buildSaveButton(),
        ),
      ),
    );
  }
}
