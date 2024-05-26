import 'package:booking_doctor/users/common/store/user.dart';
import 'package:booking_doctor/users/common/utils/convert_status.dart';
import 'package:booking_doctor/users/common/utils/date.dart';
import 'package:booking_doctor/users/common/utils/utils.dart';
import 'package:booking_doctor/users/common/values/colors_value.dart';
import 'package:booking_doctor/users/common/widgets/app_bar.dart';
import 'package:booking_doctor/users/common/widgets/my_text_style.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:booking_doctor/users/pages/appointment/appointment_detail/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppointmentDetailPage extends GetView<AppointmentDetailController> {
  const AppointmentDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppbar() {
      return CustomAppBar(
        title: Text(
          "Chi tiết phiếu khám",
          style: getMyTextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        isCenterTitle: true,
      );
    }

    Widget _rowOfItem(String title, String subtitle,
        {Color colorSubtitle = Colors.black, double fontSize = 16}) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: getMyTextStyle(
                  fontSize: fontSize.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                subtitle,
                style: getMyTextStyle(
                  fontSize: fontSize.sp,
                  color: colorSubtitle,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildContent() {
      return Obx(() {
        if (controller.state.isLoading) {
          return Center(
            child: CircularProgressIndicator(
              color: ColorsValue.secondColor,
            ),
          );
        }
        return Container(
          margin: EdgeInsets.only(bottom: 10.w, left: 10.w, right: 10.w),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      "Mã phiếu khám",
                      style: getMyTextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      controller.appointmentId,
                      style: getMyTextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10.w),
                // Divider(
                //   thickness: 0.5,
                //   color: Colors.grey.shade400,
                // ),
                _rowOfItem(
                  "Họ tên bệnh nhân",
                  controller.state.appointment!.patientName ?? "",
                  colorSubtitle: Colors.blue,
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey.shade400,
                ),
                _rowOfItem(
                  "Bác sĩ",
                  controller.state.doctor.userName ?? "",
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey.shade400,
                ),
                _rowOfItem(
                  "Chuyên khoa",
                  controller.state.appointment!.major ?? "",
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey.shade400,
                ),
                _rowOfItem(
                  "Bệnh viện",
                  controller.state.appointment?.hospitalName ?? "",
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey.shade400,
                ),
                _rowOfItem(
                  "Địa chỉ bệnh viện",
                  controller.state.appointment?.hospitalAddress ?? "",
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey.shade400,
                ),
                _rowOfItem(
                  "Ngày khám",
                  formatDate(
                      controller.state.appointment!.appointmentTime!.toDate()),
                  colorSubtitle: Colors.blue,
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey.shade400,
                ),
                _rowOfItem(
                  "Giờ khám",
                  formatTime(
                      controller.state.appointment!.appointmentTime!.toDate()),
                  colorSubtitle: Colors.blue,
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey.shade400,
                ),
                _rowOfItem(
                  "Triệu chứng",
                  controller.state.appointment?.symptoms ?? "",
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey.shade400,
                ),
                _rowOfItem(
                  "Trạng thái",
                  convertAppointmentStatus(
                    controller.state.appointment!.appointmentStatus!,
                  ),
                  colorSubtitle: getStatusColor(
                      controller.state.appointment!.appointmentStatus!),
                ),
              ],
            ),
          ),
        );
      });
    }

    Widget _buildButton(String title, Function() function) {
      return SizedBox(
        height: 40.w,
        child: getMyButton(
          isBGColors: true,
          onPressed: function,
          child: Text(
            title,
            style: getMyTextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    Widget _buildBottomButton() {
      return Obx(() {
        if (!controller.state.isLoading &&
            Role.Doctor.displayRole == UserStore.to.userLoginResponse.role &&
            controller.state.appointment!.appointmentStatus ==
                AppointmentStatus.Waiting.name) {
          return Container(
            height: 60.w,
            width: double.infinity,
            padding: EdgeInsets.all(10.w),
            child: Row(
              children: [
                Expanded(
                  child: _buildButton(
                    "Xác nhận đã khám",
                    () => controller.handleSubmitCompleted(context),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: _buildButton("Tái khám",
                      () => controller.navigateToAppointmentCalendar()),
                ),
              ],
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      });
    }

    return Scaffold(
      backgroundColor: ColorsValue.primaryColor,
      appBar: _buildAppbar(),
      body: _buildContent(),
      bottomNavigationBar: _buildBottomButton(),
    );
  }
}
