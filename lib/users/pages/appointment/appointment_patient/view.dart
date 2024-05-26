import 'package:booking_doctor/users/common/entities/appointment.dart';
import 'package:booking_doctor/users/common/values/values.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:booking_doctor/users/pages/appointment/appointment_patient/controller.dart';
import 'package:booking_doctor/users/pages/appointment/appointment_patient/widget.dart/appointment_item.dart';
import 'package:booking_doctor/users/pages/appointment/widget/empty_appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppointmentPatientPage extends StatefulWidget {
  const AppointmentPatientPage({super.key});

  @override
  State<AppointmentPatientPage> createState() => _AppointmentPatientPageState();
}

class _AppointmentPatientPageState extends State<AppointmentPatientPage>
    with TickerProviderStateMixin {
  final AppointmentPatientController controller =
      Get.find<AppointmentPatientController>();
  @override
  void initState() {
    super.initState();
    controller.state.tabController = TabController(
      length: 3,
      vsync: this,
    );
    controller.getAppointments();
  }

  @override
  void dispose() {
    super.dispose();
    controller.state.tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppBar() {
      return CustomAppBar(
        title: Text(
          "Danh sách phiếu khám",
          style: getMyTextStyle(
            fontSize: 20.sp,
            color: ColorsValue.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        isCenterTitle: true,
      );
    }

    Widget _buildContent() {
      return Column(
        children: [
          _buildTabBarHeader(),
          Flexible(
            child: Obx(() {
              if (!controller.state.isLoading) {
                return _buildTabBarContent();
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    color: ColorsValue.secondColor,
                  ),
                );
              }
            }),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildContent(),
    );
  }

  Widget _buildTabBarHeader() {
    return TabBar(
      dividerColor: Colors.transparent,
      indicatorColor: ColorsValue.secondColor,
      controller: controller.state.tabController,
      isScrollable: true,
      labelStyle: getMyTextStyle(
          fontSize: 16.sp,
          color: ColorsValue.secondColor,
          fontWeight: FontWeight.bold),
      unselectedLabelColor: Colors.grey.shade400,
      unselectedLabelStyle: getMyTextStyle(
          fontSize: 16.sp,
          color: ColorsValue.secondColor,
          fontWeight: FontWeight.bold),
      tabs: const [
        Tab(
          text: "Chờ khám",
        ),
        Tab(
          text: "Đã khám bệnh",
        ),
        Tab(
          text: "Đã huỷ lịch",
        ),
      ],
    );
  }

  Widget _buildTabBarContent() {
    return TabBarView(
      controller: controller.state.tabController,
      children: [
        // waiting list
        controller.state.appointmentWaitingList.isNotEmpty
            ? ListView.builder(
                itemCount: controller.state.appointmentWaitingList.length,
                itemBuilder: (context, index) {
                  Appointment appointment =
                      controller.state.appointmentWaitingList[index];
                  return AppointmentItem(
                    appointment: appointment,
                    tabIndex: 0,
                  );
                },
              )
            : EmptyAppointment(),
        // completed list
        controller.state.appointmentCompletedList.isNotEmpty
            ? ListView.builder(
                itemCount: controller.state.appointmentCompletedList.length,
                itemBuilder: (context, index) {
                  Appointment appointment =
                      controller.state.appointmentCompletedList[index];
                  return AppointmentItem(
                    appointment: appointment,
                    tabIndex: 1,
                  );
                },
              )
            : EmptyAppointment(),
        // cancel list
        controller.state.appointmentCancelList.isNotEmpty
            ? ListView.builder(
                itemCount: controller.state.appointmentCancelList.length,
                itemBuilder: (context, index) {
                  Appointment appointment =
                      controller.state.appointmentCancelList[index];
                  return AppointmentItem(
                    appointment: appointment,
                    tabIndex: 2,
                  );
                },
              )
            : EmptyAppointment(),
      ],
    );
  }
}
