import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:booking_doctor/users/common/values/values.dart';
import 'package:booking_doctor/users/common/widgets/shimmer_loading.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:booking_doctor/users/pages/doctors_directory/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

class DoctorsDirectoryPage extends GetView<DoctorsDirectoryController> {
  const DoctorsDirectoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppBar() {
      return CustomAppBar(
        title: Text(
          "Danh sách bác sĩ",
          style: getMyTextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        isCenterTitle: true,
      );
    }

    Widget _buildSearchForDoctor() {
      return Container(
        padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.w),
        height: 60.h,
        width: double.infinity,
        child: Obx(() {
          return TextField(
            onTap: () {
              controller.state.isOnTapSearchText = true;
            },
            onEditingComplete: () {
              controller.filterDoctors();
              Get.focusScope!.unfocus();
            },
            style: getMyTextStyle(fontSize: 16.sp),
            controller: controller.state.searchController,
            decoration: InputDecoration(
              hintText: "Nhập tên bác sĩ cần tìm kiếm",
              hintStyle:
                  getMyTextStyle(fontSize: 14.sp, color: Colors.grey.shade400),
              prefixIcon: Icon(
                Icons.search,
                color: ColorsValue.secondColor,
              ),
              suffixIcon: controller.state.isOnTapSearchText
                  ? IconItem(Icons.close, Colors.grey,
                      () => controller.onTapCloseButton(),
                      size: 20.sp)
                  : null,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 5.h, horizontal: 2.w),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          );
        }),
      );
    }

    Widget _buildLoading() {
      return Container(
        width: double.infinity,
        height: 150.w,
        margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            ClipOval(
              child: ShimmerLoading(
                height: 50.h,
                width: 50.w,
                baseColor: Colors.grey.shade200,
                highlightColor: Colors.grey.shade100,
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoading(
                  height: 20.h,
                  width: 100.w,
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade100,
                ),
                SizedBox(height: 5.h),
                ShimmerLoading(
                  height: 20.h,
                  width: 200.w,
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade100,
                ),
                SizedBox(height: 5.h),
                ShimmerLoading(
                  height: 20.h,
                  width: 200.w,
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade100,
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget _buildDoctorCard(DoctorUser doctor) {
      return InkWell(
        onTap: () => controller.navigateToDoctorDetail(doctor.userId!),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              )
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      child: FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: NetworkImage(doctor.photoUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person_outline,
                                color: Colors.grey, size: 20.w),
                            SizedBox(width: 5.w),
                            Text(
                              doctor.userName!,
                              style: getMyTextStyle(
                                fontSize: 16.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.w),
                        Row(
                          children: [
                            Icon(Icons.work_outline,
                                color: Colors.grey, size: 20.w),
                            SizedBox(width: 5.w),
                            Container(
                              color: ColorsValue.thirdColor,
                              padding: EdgeInsets.symmetric(
                                vertical: 5.h,
                                horizontal: 10.w,
                              ),
                              child: Text(
                                doctor.major!,
                                style: getMyTextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey.shade600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5.w),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Icon(
                                Icons.home_work_outlined,
                                color: Colors.grey,
                                size: 20.w,
                              ),
                              SizedBox(width: 5.w),
                              Flexible(
                                child: Text(
                                  doctor.hospitalName!,
                                  style: getMyTextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildDoctors() {
      return Obx(() {
        if (controller.state.isLoading && controller.state.doctors.isEmpty) {
          return ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              return _buildLoading();
            },
          );
        } else if (controller.state.doctors.isNotEmpty) {
          return Container(
            color: Colors.white,
            child: ScrollConfiguration(
              behavior: const ScrollBehavior().copyWith(overscroll: false),
              child: ListView.builder(
                controller: controller.state.scrollDoctorController,
                itemCount: controller.state.doctors.length,
                itemBuilder: (context, index) {
                  if (index < controller.state.doctors.length) {
                    DoctorUser doctor = controller.state.doctors[index];
                    return _buildDoctorCard(doctor);
                  } else {
                    return controller.state.isLoading ? _buildLoading() : null;
                  }
                },
              ),
            ),
          );
        } else {
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Không có kết quả nào được tìm thấy",
                style: getMyTextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey,
                ),
              )
            ],
          );
        }
      });
    }

    return Scaffold(
        appBar: _buildAppBar(),
        body: GestureDetector(
          onTap: () {
            Get.focusScope?.unfocus();
          },
          child: Column(
            children: [
              _buildSearchForDoctor(),
              Expanded(
                child: _buildDoctors(),
              ),
            ],
          ),
        ));
  }
}
