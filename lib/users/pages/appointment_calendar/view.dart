import 'package:booking_doctor/users/common/values/colors_value.dart';
import 'package:booking_doctor/users/common/widgets/app_bar.dart';
import 'package:booking_doctor/users/common/widgets/my_button.dart';
import 'package:booking_doctor/users/common/widgets/my_text_style.dart';
import 'package:booking_doctor/users/pages/appointment_calendar/controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentCalendarPage extends GetView<AppointmentCalendarController> {
  const AppointmentCalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppBar() {
      return CustomAppBar(
        isCenterTitle: true,
        title: Text(
          "Chọn thời gian",
          style: getMyTextStyle(
            fontSize: 20.sp,
            color: ColorsValue.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    Widget _buildTableCalendar() {
      return Column(
        children: [
          TableCalendar(
            rowHeight: 60,
            headerStyle: HeaderStyle(
              titleTextStyle: getMyTextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              formatButtonVisible: false,
              titleCentered: true,
            ),
            locale: 'vi_VN',
            focusedDay: controller.state.selectedDate,
            selectedDayPredicate: (day) {
              return isSameDay(controller.state.selectedDate, day);
            },
            enabledDayPredicate: (date) {
              // Trả về true nếu ngày không phải là cuối tuần
              return controller.state.isHaveData
                  ? controller.isAvailableDay(date)
                  : false;
            },
            firstDay: DateTime.utc(2024, 4, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            onDaySelected: controller.onDaySelected,
            calendarBuilders: CalendarBuilders(
              selectedBuilder: (context, date, _) {
                return controller.state.isHaveData
                    ? Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorsValue.secondColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          date.day.toString(),
                          style: getMyTextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : null;
              },
              defaultBuilder: (context, day, _) {
                return controller.state.isHaveData
                    ? Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorsValue.thirdColor.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          day.day.toString(),
                          style: getMyTextStyle(
                            color: ColorsValue.secondColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : null;
              },
              todayBuilder: (context, day, _) {
                return controller.state.isHaveData
                    ? Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: ColorsValue.thirdColor.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          day.day.toString(),
                          style: getMyTextStyle(
                            color: ColorsValue.secondColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : null;
              },
              disabledBuilder: (context, day, _) {
                return Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Text(
                    day.day.toString(),
                    style: getMyTextStyle(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      color: ColorsValue.secondColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "Hôm nay",
                    style: getMyTextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      color: ColorsValue.thirdColor.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "Còn trống",
                    style: getMyTextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    width: 20.w,
                    height: 20.w,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    "Kín lịch",
                    style: getMyTextStyle(fontSize: 16.sp),
                  ),
                ],
              )
            ],
          )
        ],
      );
    }

    Widget _buildTimeSlots() {
      if (controller.state.isHaveData) {
        return Column(
          children: [
            Text(
              "Chọn giờ khám",
              style: getMyTextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.w),
            Wrap(
              spacing: 15.w,
              runSpacing: 15.w,
              children: controller.state.availableTimeSlots.map((e) {
                bool isAvailable = controller.isAvailableTimeSlot(e);
                Color colorContainer = isAvailable
                    ? controller.state.selectedTimeSlot?.time == e.time
                        ? ColorsValue.secondColor
                        : ColorsValue.thirdColor.withOpacity(0.7)
                    : Colors.grey.shade300;
                Color colorText = isAvailable
                    ? controller.state.selectedTimeSlot?.time == e.time
                        ? Colors.white
                        : ColorsValue.secondColor
                    : Colors.grey.shade700;
                return GestureDetector(
                  onTap: () =>
                      isAvailable ? controller.onTimeSlotSelected(e) : null,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
                    decoration: BoxDecoration(
                      color: colorContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      e.time ?? "",
                      style: getMyTextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: colorText,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      }
      return Center(
        child: Text(
          "Bác sĩ chưa cập nhât lịch làm việc",
          style: getMyTextStyle(fontSize: 16.sp),
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
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTableCalendar(),
                SizedBox(height: 20.w),
                _buildTimeSlots(),
              ],
            ),
          ),
        );
      });
    }

    return Scaffold(
      backgroundColor: ColorsValue.primaryColor,
      appBar: _buildAppBar(),
      body: _buildContent(),
      bottomNavigationBar: Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        height: 60.w,
        child: controller.state.isHaveData
            ? getMyButton(
                isBGColors: true,
                onPressed: () => controller.handleSubmitBooking(context),
                child: Text(
                  "Xác nhận",
                  style: getMyTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )
            : null,
      ),
    );
  }
}
