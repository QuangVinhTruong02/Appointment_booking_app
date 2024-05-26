import 'package:booking_doctor/users/common/widgets/app_bar.dart';
import 'package:booking_doctor/users/common/widgets/my_button.dart';
import 'package:booking_doctor/users/common/widgets/my_text_style.dart';
import 'package:booking_doctor/users/pages/health_record_page/health_record_detail/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HealthRecordDetailPage extends GetView<HealthRecordDetailController> {
  const HealthRecordDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppbar() {
      return CustomAppBar(
        title: Text(
          "Xem chi tiết hồ sơ sức khỏe",
          style: getMyTextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        isCenterTitle: true,
      );
    }

    Widget _rowOfItem(String title, String subtitle) {
      return Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: getMyTextStyle(fontSize: 16.sp),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              subtitle,
              style: getMyTextStyle(fontSize: 16.sp),
            ),
          )
        ],
      );
    }

    Widget _buildContent() {
      return Padding(
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "THÔNG TIN HỒ SƠ BỆNH NHÂN",
              style: getMyTextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.w),
            _rowOfItem(
                "Họ và tên", controller.state.healthRecord?.userName ?? ""),
            SizedBox(height: 10.w),
            Divider(
              color: Colors.grey.shade300,
              thickness: 0.5,
            ),
            SizedBox(height: 10.w),
            _rowOfItem("Ngày sinh", controller.state.healthRecord?.DOB ?? ""),
            SizedBox(height: 10.w),
            Divider(
              color: Colors.grey.shade300,
              thickness: 0.5,
            ),
            SizedBox(height: 10.w),
            _rowOfItem(
                "Giới tính", controller.state.healthRecord?.gender ?? ""),
            SizedBox(height: 10.w),
            Divider(
              color: Colors.grey.shade300,
              thickness: 0.5,
            ),
            SizedBox(height: 10.w),
            _rowOfItem("Số điện thoại",
                controller.state.healthRecord?.phoneNumber ?? ""),
            SizedBox(height: 10.w),
            Divider(
              color: Colors.grey.shade300,
              thickness: 0.5,
            ),
            SizedBox(height: 10.w),
            _rowOfItem("CMND",
                controller.state.healthRecord?.IDCard ?? "Chưa cập nhật"),
            SizedBox(height: 10.w),
            Divider(
              color: Colors.grey.shade300,
              thickness: 0.5,
            ),
            SizedBox(height: 10.w),
            _rowOfItem("Địa chỉ", controller.state.healthRecord?.address ?? ""),
          ],
        ),
      );
    }

    Widget _buildBottomBar() {
      return Container(
        height: 50.w,
        padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.w),
        child: Row(
          children: [
            Expanded(
              child: getMyButton(
                isBGColors: true,
                onPressed: () => controller.handleEditHealthRecord(),
                child: Text(
                  "Chỉnh sửa",
                  style: getMyTextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              child: getMyButton(
                isBorderSide: true,
                isBGColors: true,
                onPressed: () => controller.handleDeleteHealthRecord(context),
                child: Text(
                  "Xoá hồ sơ",
                  style: getMyTextStyle(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildContent(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }
}
