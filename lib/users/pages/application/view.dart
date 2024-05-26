import 'package:booking_doctor/users/common/store/store.dart';
import 'package:booking_doctor/users/common/utils/enum_extension.dart';
import 'package:booking_doctor/users/common/values/string_manager.dart';
import 'package:booking_doctor/users/pages/appointment/appointment_doctor.dart/index.dart';
import 'package:booking_doctor/users/pages/doctor_schedules/index.dart';
import 'package:booking_doctor/users/pages/group_question/index.dart';
import 'package:booking_doctor/users/pages/health_record_page/index.dart';
import 'package:booking_doctor/users/pages/home/home_doctor/index.dart';
import 'package:booking_doctor/users/pages/appointment/appointment_patient/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/users/common/values/colors_value.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:booking_doctor/users/pages/application/controller.dart';
import 'package:booking_doctor/users/pages/home/home_patient/index.dart';
import 'package:booking_doctor/users/pages/profile/index.dart';

// ignore: must_be_immutable
class ApplicationPage extends GetView<ApplicationController> {
  ApplicationPage({super.key});

  List<Widget> page = [
    if (UserStore.to.userLoginResponse.role == Role.Patient.displayRole)
      const HomePatientPage(),
    if (UserStore.to.userLoginResponse.role == Role.Patient.displayRole)
      const HealthRecordPage(),
    if (UserStore.to.userLoginResponse.role == Role.Patient.displayRole)
      const AppointmentPatientPage(),
    if (UserStore.to.userLoginResponse.role == Role.Doctor.displayRole)
      const HomeDoctorPage(),
    if (UserStore.to.userLoginResponse.role == Role.Doctor.displayRole)
      const DoctorSchedulePage(),
    if (UserStore.to.userLoginResponse.role == Role.Doctor.displayRole)
      const AppointmentDoctorPage(),
    GroupQuestionPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    Widget _buildBottomTabs() {
      return Obx(() {
        return SizedBox(
          width: 360.w,
          height: kBottomNavigationBarHeight.h,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            iconSize: 24.w,
            selectedItemColor: ColorsValue.secondColor,
            unselectedItemColor: Colors.grey,
            currentIndex: controller.state.pageIndex,
            selectedLabelStyle: getMyTextStyle(fontSize: 12.sp),
            unselectedLabelStyle: getMyTextStyle(fontSize: 12.sp),
            onTap: (value) {
              controller.handleNavBarTap(value);
            },
            items: [
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                ),
                label: StringHomeValue.home_page,
              ),
              BottomNavigationBarItem(
                icon: UserStore.to.userLoginResponse.role ==
                        Role.Patient.displayRole
                    ? const Icon(Icons.fact_check_outlined)
                    : const Icon(Icons.calendar_today_outlined),
                label: UserStore.to.userLoginResponse.role ==
                        Role.Patient.displayRole
                    ? StringHomeValue.health_record
                    : "Lịch làm việc",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.article_outlined),
                label: StringHomeValue.medical_form,
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.groups_outlined),
                label: StringHomeValue.group_chat,
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: StringHomeValue.person,
              ),
            ],
          ),
        );
      });
    }

    Widget _buildPageView() {
      return PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        onPageChanged: (value) {
          controller.hanldeOnPageChanged(value);
        },
        children: page,
      );
      // return Obx(
      //   () {
      //     return page[controller.state.pageIndex];
      //   },
      // );
    }

    return Scaffold(
      // extendBody: true,
      // extendBodyBehindAppBar: true,
      // resizeToAvoidBottomInset: false,
      backgroundColor: ColorsValue.primaryColor,
      bottomNavigationBar: _buildBottomTabs(),
      body: _buildPageView(),
    );
  }
}
