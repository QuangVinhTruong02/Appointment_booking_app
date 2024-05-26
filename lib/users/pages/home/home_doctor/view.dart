import 'package:booking_doctor/users/common/utils/date.dart';
import 'package:booking_doctor/users/common/values/values.dart';
import 'package:booking_doctor/users/common/widgets/my_text_style.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:booking_doctor/users/pages/home/home_doctor/controller.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomeDoctorPage extends GetView<HomeDoctorController> {
  const HomeDoctorPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget _buildHeader() {
      if (controller.state.isDoctorLoading) {
        return Center(
          child: CircularProgressIndicator(
            color: ColorsValue.secondColor,
          ),
        );
      }
      return Row(
        children: [
          CachedNetworkImage(
            imageUrl: controller.state.doctor.photoUrl ?? "",
            imageBuilder: (context, imageProvider) => Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.grey.shade300,
              ),
            ),
          ),
          SizedBox(width: 20.w),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Xin chào, ${controller.state.doctor.userName}",
                  style: getMyTextStyle(
                    fontSize: 20.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.w),
                Text(
                  "Chúc bạn một ngày tốt lành!",
                  style: getMyTextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    AppBar _buildAppbar() {
      return CustomAppBar(
        title: Text(
          "Trang chủ",
          style: getMyTextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        isCenterTitle: true,
      );
    }

    Widget _buildAppointmentOverview() {
      return Column(
        children: [
          CardItem(
            tile: "Đã khám",
            subtitle: "${controller.state.totalAppointmentsSuccess} bệnh nhân",
            colors: Colors.green,
            icon: Icons.check_circle,
          ),
          SizedBox(height: 20.w),
          CardItem(
            tile: "Đang chờ",
            subtitle: "${controller.state.totalAppointmentsWaiting} bệnh nhân",
            colors: Colors.orange.shade300,
            icon: Icons.pending_actions,
          ),
          SizedBox(height: 20.w),
          CardItem(
            tile: "Đã hủy",
            subtitle: "${controller.state.totalAppointmentsCancel} bệnh nhân",
            colors: Colors.red,
            icon: Icons.cancel,
          ),
        ],
      );
    }

    Widget _buildOverView() {
      if (controller.state.isAppointmentOverviewLoading)
        return Center(
          child: CircularProgressIndicator(
            color: ColorsValue.secondColor,
          ),
        );
      final formatter = DateFormat("EEEE", "vi");
      return Padding(
        padding: EdgeInsets.only(top: 20.w, left: 10.w, right: 10.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 20.w),
              Text(
                "Tổng quan cuộc hẹn",
                style: getMyTextStyle(
                    fontSize: 18.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.w),
              Text(
                "${formatter.format(DateTime.now())}, Ngày ${formatDate(DateTime.now())}",
                style: getMyTextStyle(
                    fontSize: 18.sp,
                    color: ColorsValue.secondColor.withOpacity(0.8),
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.w),
              _buildAppointmentOverview(),
            ],
          ),
        ),
      );
    }

    Widget _buildContent() {
      return Obx(
        () {
          return SingleChildScrollView(
            child: Column(
              children: [
                _buildOverView(),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: ColorsValue.primaryColor,
      appBar: _buildAppbar(),
      body: _buildContent(),
    );
  }
}

class CardItem extends StatelessWidget {
  final String tile;
  final String subtitle;
  final Color colors;
  final IconData icon;
  CardItem({
    super.key,
    required this.tile,
    required this.subtitle,
    required this.colors,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 80.h,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 80.h,
            decoration: BoxDecoration(
              color: colors,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
          ),
          Positioned.fill(
            top: 0.w,
            left: 20.w,
            right: 0.w,
            bottom: 0.w,
            child: Container(
              width: double.infinity,
              height: 60.h,
              padding: EdgeInsets.symmetric(vertical: 10.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.r),
              ),
              child: ListTile(
                title: Padding(
                  padding: EdgeInsets.only(bottom: 10.w),
                  child: Text(
                    tile,
                    style: getMyTextStyle(
                      fontSize: 18.sp,
                      color: colors,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                subtitle: Text(
                  subtitle,
                  style: getMyTextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                  ),
                ),
                leading: Icon(
                  icon,
                  color: colors,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
