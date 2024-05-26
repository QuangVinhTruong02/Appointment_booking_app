import 'package:booking_doctor/users/common/values/colors_value.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:booking_doctor/users/pages/doctor_schedules/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget modalBottomSheet(BuildContext context) {
  final controller = Get.find<DoctorScheduleController>();
  return FractionallySizedBox(
    heightFactor: 0.6,
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      child: SingleChildScrollView(
        child: Obx(
          () {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ngày làm việc",
                  style:
                      getMyTextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.w),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.state.listWorkingDay.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      activeColor: ColorsValue.secondColor,
                      contentPadding: EdgeInsets.symmetric(horizontal: 0),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: controller.state.listWorkingDay[index].value,
                      onChanged: (value) {
                        controller.onChangeWorkingDay(
                          value!,
                          index,
                        );
                      },
                      title: Text(
                        controller.state.listWorkingDay[index].name,
                        style: getMyTextStyle(fontSize: 16.sp),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10.w),
                Text(
                  "Giờ làm việc",
                  style:
                      getMyTextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.state.listWorkingTime.length,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                      activeColor: ColorsValue.secondColor,
                      contentPadding: EdgeInsets.symmetric(horizontal: 0),
                      controlAffinity: ListTileControlAffinity.leading,
                      value: controller.state.listWorkingTime[index].value,
                      onChanged: (value) => controller.onChangeWorkingTime(
                        value ?? false,
                        index,
                      ),
                      title: Text(
                        controller.state.listWorkingTime[index].name,
                        style: getMyTextStyle(fontSize: 16.sp),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10.w),
                SizedBox(
                  height: 40.w,
                  child: getMyButton(
                    isBGColors: true,
                    onPressed: () => controller.handleSaveChange(context),
                    child: Text(
                      "Lưu",
                      style: getMyTextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ),
  );
}
