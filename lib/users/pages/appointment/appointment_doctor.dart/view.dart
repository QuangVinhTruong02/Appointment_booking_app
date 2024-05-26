import 'package:booking_doctor/users/common/entities/appointment.dart';
import 'package:booking_doctor/users/common/values/colors_value.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:booking_doctor/users/pages/appointment/appointment_doctor.dart/controller.dart';
import 'package:booking_doctor/users/pages/appointment/appointment_doctor.dart/widget/appointment_of_doctor_item.dart';
import 'package:booking_doctor/users/pages/appointment/widget/empty_appointment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppointmentDoctorPage extends StatefulWidget {
  const AppointmentDoctorPage({super.key});

  @override
  State<AppointmentDoctorPage> createState() => _AppointmentDoctorPageState();
}

class _AppointmentDoctorPageState extends State<AppointmentDoctorPage>
    with SingleTickerProviderStateMixin {
  final controller = Get.find<AppointmentDoctorController>();
  @override
  void initState() {
    super.initState();
    controller.state.tabController = TabController(length: 2, vsync: this);
    controller.listBinds();
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
        isCenterTitle: true,
        title: Text(
          "Lịch hẹn",
          style: getMyTextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    Widget _buildTabBarHeader() {
      return TabBar(
        dividerColor: Colors.transparent,
        indicatorColor: ColorsValue.secondColor,
        controller: controller.state.tabController,
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
            text: "Lịch hẹn sắp tới",
          ),
          Tab(
            text: "Lịch hẹn trong ngày",
          ),
        ],
      );
    }

    Widget _buildUpcomingList() {
      if (controller.state.appointmentUpcomingList.isEmpty) {
        return const EmptyAppointment();
      }
      return ListView.builder(
        itemCount: controller.state.appointmentUpcomingList.length,
        itemBuilder: (context, index) {
          Appointment appointment =
              controller.state.appointmentUpcomingList[index];
          return AppointmentOfDoctorItem(
            appointment: appointment,
          );
        },
      );
    }

    Widget _buildAllList() {
      if (controller.state.appointmentAllList.isEmpty) {
        return const EmptyAppointment();
      }
      return ListView.builder(
        itemCount: controller.state.appointmentAllList.length,
        itemBuilder: (context, index) {
          Appointment appointment = controller.state.appointmentAllList[index];
          return AppointmentOfDoctorItem(
            appointment: appointment,
          );
        },
      );
    }

    Widget _buildTabBarView() {
      return TabBarView(
        controller: controller.state.tabController,
        children: [
          SmartRefresher(
            controller: controller.state.refreshUpcomingController,
            header: const WaterDropHeader(),
            onRefresh: controller.onUpcomingRefresh,
            child: _buildUpcomingList(),
          ),
          SmartRefresher(
            controller: controller.state.refreshAllController,
            header: const WaterDropHeader(),
            onRefresh: controller.onAllRefresh,
            child: _buildAllList(),
          ),
        ],
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
        return Column(
          children: [
            _buildTabBarHeader(),
            Flexible(
              child: _buildTabBarView(),
            ),
          ],
        );
      });
    }

    return Scaffold(
      backgroundColor: ColorsValue.primaryColor,
      appBar: _buildAppBar(),
      body: _buildContent(),
    );
  }
}
