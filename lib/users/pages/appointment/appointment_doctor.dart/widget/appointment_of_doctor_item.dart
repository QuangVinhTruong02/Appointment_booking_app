import 'package:booking_doctor/users/common/entities/appointment.dart';
import 'package:booking_doctor/users/common/utils/convert_status.dart';
import 'package:booking_doctor/users/common/utils/date.dart';
import 'package:booking_doctor/users/common/values/values.dart';
import 'package:booking_doctor/users/common/widgets/my_text_style.dart';
import 'package:booking_doctor/users/pages/appointment/appointment_doctor.dart/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppointmentOfDoctorItem extends StatelessWidget {
  final Appointment appointment;
  const AppointmentOfDoctorItem({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppointmentDoctorController>();
    Widget _listTile(String title, String subtitle,
        {Color colorSubtitle = Colors.black}) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              style: getMyTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              subtitle,
              style: getMyTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: colorSubtitle,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      child: InkWell(
        onTap: () =>
            controller.navigateToAppointmentDetail(appointment.appointmentId!),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _listTile("Mã phiếu: ", appointment.appointmentId ?? ""),
                SizedBox(height: 10.w),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                ),
                SizedBox(height: 10.w),
                _listTile("Họ và tên bệnh nhân:", appointment.patientName ?? "",
                    colorSubtitle: ColorsValue.secondColor),
                SizedBox(height: 10.w),
                _listTile(
                  "Thời gian khám:",
                  formatDate(
                    appointment.appointmentTime!.toDate(),
                  ),
                ),
                SizedBox(height: 10.w),
                _listTile(
                  "Giờ khám:",
                  formatTime(
                    appointment.appointmentTime!.toDate(),
                  ),
                ),
                SizedBox(height: 10.w),
                _listTile("Chuyên khoa:", appointment.major ?? ""),
                SizedBox(height: 10.w),
                _listTile(
                  "Trạng thái:",
                  convertAppointmentStatus(appointment.appointmentStatus ?? ""),
                  colorSubtitle:
                      getStatusColor(appointment.appointmentStatus ?? ""),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
