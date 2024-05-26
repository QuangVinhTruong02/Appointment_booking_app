import 'package:booking_doctor/users/common/entities/appointment.dart';
import 'package:booking_doctor/users/common/store/store.dart';
import 'package:booking_doctor/users/common/utils/date.dart';
import 'package:booking_doctor/users/common/utils/enum_extension.dart';
import 'package:booking_doctor/users/common/values/colors_value.dart';
import 'package:booking_doctor/users/common/widgets/my_text_style.dart';
import 'package:booking_doctor/users/pages/appointment/appointment_patient/controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppointmentItem extends StatefulWidget {
  final Appointment appointment;
  final int tabIndex;
  const AppointmentItem({
    super.key,
    required this.appointment,
    required this.tabIndex,
  });

  @override
  State<AppointmentItem> createState() => _AppointmentItemState();
}

class _AppointmentItemState extends State<AppointmentItem> {
  String selectedValue = "";
  final controller = Get.find<AppointmentPatientController>();
  @override
  void initState() {
    super.initState();
    selectedValue = widget.appointment.appointmentStatus ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      child: InkWell(
        onTap: () => controller.navigateToAppointmentDetail(
            widget.appointment.appointmentId ?? ""),
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _listTile("Mã phiếu: ", widget.appointment.appointmentId ?? ""),
                SizedBox(height: 5.w),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1,
                ),
                Text(
                  widget.appointment.patientName ?? "",
                  style: getMyTextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                SizedBox(height: 10.w),
                _listTile(
                    "Thời gian khám:",
                    formatDate(widget.appointment.appointmentTime!.toDate()) ??
                        ""),
                SizedBox(height: 10.w),
                _listTile(
                    "Giờ khám:",
                    formatTime(widget.appointment.appointmentTime!.toDate()) ??
                        ""),
                SizedBox(height: 10.w),
                _listTile("Chuyên khoa:", widget.appointment.major ?? ""),
                SizedBox(height: 10.w),
                _listTile("Bệnh viện:", widget.appointment.hospitalName ?? ""),
                SizedBox(height: 10.w),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trạng thái",
                      style: getMyTextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(width: 10.w),
                    if (widget.tabIndex == 0) _buildStatusDropdown(),
                    if (widget.tabIndex != 0) _buildStatusLocked(),
                  ],
                ),
                if (widget.tabIndex != 2 && widget.tabIndex != 3)
                  SizedBox(height: 5.w),
                if (widget.tabIndex != 2 && widget.tabIndex != 3)
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                if (widget.tabIndex != 2 && widget.tabIndex != 3)
                  SizedBox(height: 5.w),
                if (widget.tabIndex != 2 && widget.tabIndex != 3)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.appointment.appointmentStatus ==
                                AppointmentStatus.Waiting.name
                            ? "Thanh toán tại quầy: "
                            : "Đã thanh toán: ",
                        style: getMyTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsValue.secondColor,
                        ),
                      ),
                      Text(
                        formatCurrency(widget.appointment.price ?? 0),
                        style: getMyTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorsValue.secondColor,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _listTile(String title, String subtitle) {
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
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  DropdownButtonHideUnderline _buildStatusDropdown() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        value: selectedValue,
        onChanged: (value) {
          selectedValue = value ?? "";
          if (selectedValue == AppointmentStatus.Canceled.name) {
            controller.handleCancelAppointment(widget.appointment, context);
          }
        },
        style: getMyTextStyle(
            fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.white),
        buttonStyleData: ButtonStyleData(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          decoration: BoxDecoration(
            color: ColorsValue.secondColor,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        iconStyleData: const IconStyleData(
            iconDisabledColor: Colors.white, iconEnabledColor: Colors.white),
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: ColorsValue.secondColor.withOpacity(0.8),
          ),
        ),
        items: [
          DropdownMenuItem(
            value: AppointmentStatus.Waiting.name,
            child: const Text(
              "Chờ khám",
            ),
          ),
          if (UserStore.to.userLoginResponse.role == Role.Patient.displayRole)
            DropdownMenuItem(
              value: AppointmentStatus.Canceled.name,
              child: const Text(
                "Huỷ lịch hẹn",
              ),
            ),
          if (UserStore.to.userLoginResponse.role == Role.Doctor.displayRole)
            DropdownMenuItem(
              value: AppointmentStatus.Completed.name,
              child: const Text(
                "Đã khám",
              ),
            ),
        ],
      ),
    );
  }

  _buildStatusLocked() {
    String status = AppointmentStatus.values
        .singleWhere(
            (element) => element.name == widget.appointment.appointmentStatus)
        .displayStatus;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      decoration: BoxDecoration(
        color:
            widget.tabIndex == 1 ? Colors.green.shade500 : Colors.red.shade500,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Text(
            status,
            style: getMyTextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(width: 10.w),
          Icon(
            Icons.lock_outline_rounded,
            color: Colors.white,
            size: 20.sp,
          )
        ],
      ),
    );
  }
}
