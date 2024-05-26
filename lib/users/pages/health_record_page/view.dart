import 'package:booking_doctor/users/common/entities/health_record.dart';
import 'package:booking_doctor/users/common/values/colors_value.dart';
import 'package:booking_doctor/users/common/widgets/app_bar.dart';
import 'package:booking_doctor/users/common/widgets/my_text_style.dart';
import 'package:booking_doctor/users/pages/health_record_page/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HealthRecordPage extends StatefulWidget {
  const HealthRecordPage({super.key});

  @override
  State<HealthRecordPage> createState() => _HealthRecordPageState();
}

class _HealthRecordPageState extends State<HealthRecordPage> {
  final controller = Get.find<HeathRecordController>();

  @override
  void initState() {
    super.initState();
    controller.getHealthRecord();
  }

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppbar() {
      return CustomAppBar(
        title: Text(
          "Hồ sơ khám sức khoẻ",
          style: getMyTextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        isCenterTitle: true,
      );
    }

    Widget _buildFloatingActionButton() {
      return FloatingActionButton.extended(
        backgroundColor: ColorsValue.secondColor.withOpacity(0.8),
        onPressed: () {
          controller.navigateHealthRecordFormPage();
        },
        icon: const Icon(
          Icons.person_add,
          color: Colors.white,
        ),
        label: Text(
          "Tạo mới",
          style: getMyTextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
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

    Widget _buildContent() {
      return Obx(
        () {
          if (controller.state.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: ColorsValue.secondColor,
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10.w),
                    color: Colors.grey.shade300,
                    child: Text(
                      "Vui lòng chọn hồ sơ bên dưới hoặc tạo mới hồ sơ khám sức khoẻ",
                      style:
                          getMyTextStyle(fontSize: 16.sp, color: Colors.black),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.state.healthRecords.length,
                    itemBuilder: (context, index) {
                      HealthRecord healthRecord =
                          controller.state.healthRecords[index];
                      return InkWell(
                        onTap: () => controller
                            .navigateHealthRecordDetailPage(healthRecord),
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
                                    color: ColorsValue.secondColor,
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
                  ),
                ],
              ),
            );
          }
        },
      );
    }

    return Scaffold(
      backgroundColor: ColorsValue.primaryColor,
      appBar: _buildAppbar(),
      body: _buildContent(),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }
}
