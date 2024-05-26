import 'package:booking_doctor/users/common/entities/doctor.dart';
import 'package:booking_doctor/users/common/entities/hospital.dart';
import 'package:booking_doctor/users/common/values/string_manager.dart';
import 'package:booking_doctor/users/common/values/values.dart';
import 'package:booking_doctor/users/common/widgets/my_text_style.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/users/common/values/colors_value.dart';
import 'package:booking_doctor/users/pages/home/home_patient/controller.dart';

class HomePatientPage extends GetView<HomePatientController> {
  const HomePatientPage({super.key});

  Widget _buildHeader() {
    return FittedBox(
      child: Container(
        height: 100.h,
        width: 360.w,
        padding: EdgeInsets.only(
          left: 20.w,
          top: kToolbarHeight.w,
          right: 20.w,
        ),
        decoration: BoxDecoration(
          gradient: ColorsValue.linearPrimary,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              StringHomeValue.title,
              style: getMyTextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorList() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      width: 360.w,
      color: Colors.blueGrey.shade50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //title
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 10.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  StringHomeValue.doctor_list,
                  style: getMyTextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                InkWell(
                  onTap: () => controller.navigateToDoctorsDirectory(),
                  child: SizedBox(
                    child: Row(
                      children: [
                        Text(
                          "Xem thêm",
                          style: getMyTextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 12.r,
                          color: Colors.grey.shade600,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 10.w),
            child: Text(
              StringHomeValue.note_1,
              style:
                  getMyTextStyle(fontSize: 14.sp, color: Colors.grey.shade600),
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            height: 260.h,
            width: 360.w,
            child: ListView.builder(
              // padEnds: false,
              // controller: controller.state.pageController,
              scrollDirection: Axis.horizontal,
              // physics: PageScrollPhysics(),
              itemCount: controller.state.doctors.length,
              itemBuilder: (context, index) {
                if (index < controller.state.doctors.length) {
                  DoctorUser doctorUser = controller.state.doctors[index];
                  return _buildDoctorCard(doctorUser);
                } else {
                  return controller.state.isLoading
                      ? Center(
                          child: CircularProgressIndicator(
                            color: ColorsValue.secondColor,
                          ),
                        )
                      : null;
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDoctorCard(DoctorUser doctorUser) {
    return InkWell(
      onTap: () {
        controller.navigateDoctorDetail(doctorUser.userId!);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        width: 150.w,
        margin: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 3),
              spreadRadius: 1,
              blurRadius: 2,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CachedNetworkImage(
              imageUrl: doctorUser.photoUrl!,
              placeholder: (context, url) => Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  shape: BoxShape.circle,
                ),
                height: 60.h,
                width: 60.w,
              ),
              imageBuilder: (context, imageProvider) => Container(
                height: 60.h,
                width: 60.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              doctorUser.userName!,
              style: getMyTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //TODO: sửa lại lượt đặt lịch, có lượt rating
                Icon(
                  Icons.calendar_month,
                  color: ColorsValue.secondColor,
                  size: 15.sp,
                ),
                Text(
                  "5",
                  style: getMyTextStyle(fontSize: 12.sp),
                )
              ],
            ),
            SizedBox(height: 5.h),
            Container(
              color: ColorsValue.thirdColor,
              padding: EdgeInsets.symmetric(
                vertical: 5.h,
                horizontal: 10.w,
              ),
              child: Text(
                doctorUser.major!,
                style: getMyTextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey.shade600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              doctorUser.hospitalName!,
              style: getMyTextStyle(
                fontSize: 12.sp,
                color: Colors.grey.shade600,
              ),
              maxLines: 2,
            ),
            SizedBox(height: 5.h),
            SizedBox(
              height: 30.w,
              width: 100.w,
              child: getMyButton(
                radius: 8.r,
                onPressed: () =>
                    controller.navigateDoctorDetail(doctorUser.userId!),
                child: Text(
                  StringHomeValue.advise,
                  style: getMyTextStyle(
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                ),
                isBGColors: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHospitalList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //title
        Padding(
          padding: EdgeInsets.only(left: 20.w, right: 10.w, top: 20.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                StringHomeValue.hospital_list,
                style: getMyTextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              InkWell(
                child: SizedBox(
                  child: Row(
                    children: [
                      Text(
                        "Xem thêm",
                        style: getMyTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 12.r,
                        color: Colors.grey.shade600,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),

        SizedBox(height: 10.h),
        Container(
          height: 200.h,
          width: 360.w,
          child: ListView.builder(
            // padEnds: false,
            // controller: controller.state.pageController,
            scrollDirection: Axis.horizontal,
            // physics: PageScrollPhysics(),
            itemCount: controller.state.hospitals.length,
            itemBuilder: (context, index) {
              if (index < controller.state.hospitals.length) {
                Hospital hospital = controller.state.hospitals[index];

                return _buildHospital(hospital);
              } else {
                return controller.state.isLoadingHospital
                    ? Center(
                        child: CircularProgressIndicator(
                          color: ColorsValue.secondColor,
                        ),
                      )
                    : null;
              }
            },
          ),
        )
      ],
    );
  }

  Container _buildHospital(Hospital hospital) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      width: 150.w,
      height: 200.w,
      margin: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0, 3),
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CachedNetworkImage(
            imageUrl: hospital.hospitalImg!,
            placeholder: (context, url) => Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                shape: BoxShape.circle,
              ),
              height: 60.h,
              width: 60.w,
            ),
            imageBuilder: (context, imageProvider) => Container(
              height: 60.h,
              width: 60.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            hospital.hospitalName,
            style: getMyTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
          SizedBox(height: 5.h),
          Text(
            hospital.hospitalAddress,
            style: getMyTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return !controller.state.isLoading
              ? CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _buildHeader(),
                    ),
                    SliverPadding(padding: EdgeInsets.only(top: 20.h)),
                    SliverToBoxAdapter(
                      child: _buildDoctorList(),
                    ),
                    SliverPadding(padding: EdgeInsets.only(top: 20.h)),
                    SliverToBoxAdapter(
                      child: _buildHospitalList(),
                    ),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(
                    color: ColorsValue.secondColor,
                  ),
                );
        },
      ),
    );
  }
}
