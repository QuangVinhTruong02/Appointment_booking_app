import 'package:booking_doctor/common/values/values.dart';
import 'package:booking_doctor/common/widgets/icon_item.dart';
import 'package:booking_doctor/common/widgets/my_button.dart';
import 'package:booking_doctor/common/widgets/my_text_style.dart';
import 'package:booking_doctor/common/widgets/text_field.dart';
import 'package:booking_doctor/pages/edit_profile/doctor/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';

void showAddWorkExperienceDialog(
    BuildContext context, EditProfileDoctorController controller) {
  showModalBottomSheet(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12.r),
      ),
    ),
    context: context,
    builder: (context) {
      return Obx(() {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            height: 400.h,
            padding: EdgeInsets.only(
              top: 20.w,
              left: 20.w,
            ),
            child: Material(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    StringProfileValue.work_experience,
                    style: getMyTextStyle(
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 5,
                              child: MyTextField(
                                hint: StringProfileValue.work_experience,
                                controller:
                                    controller.state.workExperienceController,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconItem(
                                Icons.add,
                                ColorsValue.secondColor,
                                () => controller.handleAddWorkExperience(),
                              ),
                            ),
                          ],
                        ),
                        Flexible(
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return Divider();
                            },
                            itemCount:
                                controller.state.workExperienceList.length,
                            itemBuilder: (context, index) {
                              String item =
                                  controller.state.workExperienceList[index];
                              return Padding(
                                padding:
                                    EdgeInsets.fromLTRB(0.w, 10.h, 20.w, 10.h),
                                child: Text(
                                  "- ${item}",
                                  style: getMyTextStyle(fontSize: 16.sp),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    },
  );
}

void showAddWorkProgressDialog(
    BuildContext context, EditProfileDoctorController controller,
    {bool isEdit = false, int? index}) {
  showModalBottomSheet(
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12.r),
      ),
    ),
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          height: 300.h,
          padding: EdgeInsets.all(20.w),
          child: Material(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringProfileValue.work_progress,
                  style: getMyTextStyle(
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyTextField(
                        hint: "From year",
                        controller:
                            controller.state.fromYearWorkProgressController,
                        readOnly: true,
                        onTap: () {
                          showPickNumberYear(context, controller);
                        },
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: MyTextField(
                        hint: "To year",
                        controller:
                            controller.state.toYearWorkProgressController,
                        readOnly: true,
                        onTap: () {
                          showPickNumberYear(context, controller);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: MyTextField(
                    hint: "Work at",
                    controller: controller.state.workAtController,
                  ),
                ),
                SizedBox(height: 20.h),
                SizedBox(
                  height: 50.h,
                  child: getMyButton(
                    isBGColors: true,
                    onPressed: () => isEdit
                        ? index != null
                            ? controller.handleSaveEdit(index)
                            : {}
                        : controller.handleSaveWorkProgress(context),
                    child: Text(
                      "Lưu",
                      style: getMyTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showPickNumberYear(
    BuildContext context, EditProfileDoctorController controller) {
  showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(12.r),
            ),
            color: Colors.white,
          ),
          width: 280.w,
          child: Material(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Pick year",
                  style: getMyTextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      NumberPicker(
                        zeroPad: true,
                        minValue: 1990,
                        maxValue: DateTime.now().year,
                        value: controller.pickFromYear.value,
                        onChanged: (value) {
                          controller.handleChangePickFromYear(value);
                        },
                        selectedTextStyle: getMyTextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsValue.secondColor),
                        textStyle: getMyTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: ColorsValue.thirdColor),
                            bottom: BorderSide(color: ColorsValue.thirdColor),
                          ),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      SizedBox(
                        width: 10.w,
                        child: const Divider(
                          color: Colors.black,
                          thickness: 2,
                          height: 2,
                        ),
                      ),
                      SizedBox(width: 5.w),
                      NumberPicker(
                        minValue: 1990,
                        maxValue: DateTime.now().year,
                        value: controller.pickToYear.value,
                        onChanged: (value) {
                          controller.handleChangePickToYear(value);
                        },
                        selectedTextStyle: getMyTextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: ColorsValue.secondColor),
                        textStyle: getMyTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.black),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: ColorsValue.thirdColor),
                            bottom: BorderSide(color: ColorsValue.thirdColor),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(height: 10.h),
                getMyButton(
                  isBGColors: true,
                  onPressed: () {
                    controller.handleSelectedYear();
                  },
                  child: Text(
                    "Select",
                    style: getMyTextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}
