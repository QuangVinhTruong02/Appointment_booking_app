import 'package:booking_doctor/users/common/values/colors_value.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:booking_doctor/users/pages/doctor_schedules/controller.dart';
import 'package:booking_doctor/users/pages/doctor_schedules/widget/show_modal_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:table_calendar/table_calendar.dart';

class DoctorSchedulePage extends GetView<DoctorScheduleController> {
  const DoctorSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppBar() {
      return CustomAppBar(
        isCenterTitle: true,
        title: Text(
          "Lịch làm việc",
          style: getMyTextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    FloatingActionButton _buildFloatingActionButton() {
      return FloatingActionButton(
        backgroundColor: ColorsValue.secondColor,
        onPressed: () => myShowModal(
          context: context,
          child: modalBottomSheet(context),
        ),
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      );
    }

    Widget _buildContent() {
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
              _buildTableCalendar(),
              SizedBox(height: 20.w),
              _buildTimeSlots(),
            ],
          ),
        );
      }
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: EdgeInsets.only(top: 15.w, left: 15.w, right: 15.w),
        child: Obx(() {
          return _buildContent();
        }),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  TableCalendar _buildTableCalendar() {
    return TableCalendar(
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
      focusedDay: controller.state.toDay,
      selectedDayPredicate: (day) {
        return isSameDay(controller.state.toDay, day);
      },
      enabledDayPredicate: (date) {
        // Trả về true nếu ngày không phải là cuối tuần
        return controller.isAvailableDay(date);
      },
      firstDay: DateTime.utc(2024, 4, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      onDaySelected: controller.onDaySelected,
      calendarBuilders: CalendarBuilders(
        selectedBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ColorsValue.secondColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              date.day.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
        defaultBuilder: (context, day, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              day.day.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
        disabledBuilder: (context, day, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              day.day.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeSlots() {
    return Column(
      children: [
        Text(
          "Thời gian làm việc",
          style: getMyTextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.w),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.state.timeSlots.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                controller.state.timeSlots[index].time ?? "",
                style: getMyTextStyle(fontSize: 16.sp),
              ),
            );
          },
        ),
      ],
    );
  }
}
