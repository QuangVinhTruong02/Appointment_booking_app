import 'package:booking_doctor/users/common/entities/health_record.dart';
import 'package:booking_doctor/users/common/values/values.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:booking_doctor/users/pages/confirm_appointment/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void showHealthRecordBottomSheet(BuildContext context) {
  final controller = Get.find<ConfirmAppointmentController>();
  myShowModal(
    context: context,
    child: FractionallySizedBox(
      heightFactor: 0.6,
      child: Padding(
        padding: EdgeInsets.only(top: 20.w),
        child: Column(
          children: [
            Text(
              "Chọn hồ sơ sức khoẻ",
              style: getMyTextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.w),
            Obx(() {
              if (controller.state.isLoadingHealthRecord) {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorsValue.secondColor,
                  ),
                );
              } else {
                if (controller.state.healthRecords.isEmpty) {
                  return Center(
                    child: Text("Không có hồ sơ sức khỏe nào"),
                  );
                } else {
                  return ListView.separated(
                    itemCount: controller.state.healthRecords.length,
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => SizedBox(
                      height: 10.w,
                    ),
                    itemBuilder: (context, index) {
                      HealthRecord healthRecord =
                          controller.state.healthRecords[index];
                      return InkWell(
                        onTap: () => controller
                            .onTapSeletectedHealthRecord(healthRecord),
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          margin: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.w),
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                blurRadius: 5,
                                spreadRadius: 1,
                                offset: Offset(0, 1),
                              )
                            ],
                          ),
                          child: Column(
                            children: [
                              _rowOfItem(
                                Text(
                                  healthRecord.userName ?? "",
                                  style: getMyTextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                Icons.person,
                              ),
                              SizedBox(height: 10.w),
                              _rowOfItem(
                                Text(
                                  healthRecord.DOB ?? "",
                                  style: getMyTextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Icons.calendar_month,
                              ),
                              SizedBox(height: 10.w),
                              _rowOfItem(
                                Text(
                                  healthRecord.phoneNumber ?? "",
                                  style: getMyTextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Icons.phone,
                              ),
                              SizedBox(height: 10.w),
                              _rowOfItem(
                                Text(
                                  healthRecord.address ?? "",
                                  style: getMyTextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                Icons.location_on,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }
            }),
          ],
        ),
      ),
    ),
  );
}

Widget _rowOfItem(Text text, IconData iconData) {
  return Row(
    children: [
      Icon(
        iconData,
        color: Colors.grey,
      ),
      SizedBox(
        width: 10.w,
      ),
      text,
    ],
  );
}
