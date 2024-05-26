import 'package:booking_doctor/users/common/values/colors_value.dart';
import 'package:booking_doctor/users/common/widgets/app_bar.dart';
import 'package:booking_doctor/users/common/widgets/my_button.dart';
import 'package:booking_doctor/users/common/widgets/my_text_style.dart';
import 'package:booking_doctor/users/pages/doctor_detail/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:transparent_image/transparent_image.dart';

class DoctorDetailPage extends GetView<DoctorDetailController> {
  const DoctorDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppBar() {
      return CustomAppBar(
        title: Text(
          "Thông tin bác sĩ",
          style: getMyTextStyle(
            fontSize: 20.sp,
            color: ColorsValue.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        isCenterTitle: true,
      );
    }

    Widget _buildInfoDoctor() {
      return SliverToBoxAdapter(
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ]),
          child: Column(
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Container(
                      width: 100.w,
                      height: 100.h,
                      child: FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        image: NetworkImage(controller.state.doctor.photoUrl!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.person_outline,
                                color: Colors.grey, size: 20.w),
                            SizedBox(width: 5.w),
                            Text(
                              controller.state.doctor.userName!,
                              style: getMyTextStyle(
                                fontSize: 16.sp,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.w),
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
                                controller.state.doctor.major!,
                                style: getMyTextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey.shade600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.w),
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
                                  controller.state.doctor.hospitalName!,
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
              SizedBox(height: 10.w),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: ColorsValue.thirdColor.withOpacity(0.5),
                ),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Lượt đánh giá",
                            style: getMyTextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5.w),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.star,
                                  color: Colors.yellow, size: 20.w),
                              Text(
                                "5/5",
                                style: getMyTextStyle(
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const VerticalDivider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                      Column(
                        children: [
                          Text(
                            "Lượt đặt khám",
                            style: getMyTextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5.w),
                          Text(
                            "110",
                            style:
                                getMyTextStyle(fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }

    Widget _buildDescriptionDoctor() {
      return SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.only(top: 10.h),
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Quá trình làm việc",
                style: getMyTextStyle(
                  fontSize: 16.sp,
                  color: ColorsValue.secondColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.w),
              Text(
                controller.state.descriptionWorkProgress,
                style: getMyTextStyle(
                  fontSize: 16.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 5.w),
            ],
          ),
        ),
      );
    }

    // Widget _buildSchedule() {
    //   return SliverToBoxAdapter(
    //     child: Container(
    //       margin: EdgeInsets.only(top: 10.h),
    //       padding: EdgeInsets.symmetric(
    //         vertical: 10.h,
    //       ),
    //       decoration: BoxDecoration(
    //         color: Colors.white,
    //         boxShadow: [
    //           BoxShadow(
    //             color: Colors.grey.withOpacity(0.5),
    //             spreadRadius: 1,
    //             blurRadius: 3,
    //             offset: const Offset(0, 3),
    //           ),
    //         ],
    //       ),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Container(
    //             width: double.infinity,
    //             padding: EdgeInsets.only(bottom: 5.w, left: 10.w),
    //             child: Text(
    //               "Lịch làm việc",
    //               style: getMyTextStyle(
    //                 fontSize: 16.sp,
    //                 color: ColorsValue.secondColor,
    //                 fontWeight: FontWeight.bold,
    //               ),
    //             ),
    //           ),
    //           SizedBox(height: 10.w),
    //           if (controller.state.workSchedule == null ||
    //               controller.state.workSchedule?.calendars == null ||
    //               controller.state.workSchedule!.calendars!.isEmpty)
    //             Padding(
    //               padding: EdgeInsets.only(left: 10.w),
    //               child: Text(
    //                 "Bác sĩ chưa cập nhật lịch làm việc",
    //                 style: getMyTextStyle(
    //                   fontSize: 16.sp,
    //                   color: Colors.black,
    //                   fontWeight: FontWeight.normal,
    //                 ),
    //               ),
    //             ),
    //           if (controller.state.workSchedule != null &&
    //               controller.state.workSchedule?.calendars != null &&
    //               controller.state.workSchedule!.calendars!.isNotEmpty)
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Container(
    //                   height: 50.h,
    //                   margin: EdgeInsets.only(left: 10.w, right: 2.w),
    //                   child: _buildDays(),
    //                 ),
    //                 SizedBox(height: 10.w),
    //                 Container(
    //                   height: 50.w,
    //                   width: double.infinity,
    //                   decoration: BoxDecoration(
    //                     color: Colors.grey.shade300,
    //                   ),
    //                   child: _buildTimes(),
    //                 ),
    //               ],
    //             )
    //         ],
    //       ),
    //     ),
    //   );
    // }

    Widget _buildButtonNavBottom() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
        height: 60.w,
        child: getMyButton(
          isBGColors: true,
          onPressed: () => controller.navigateToAppointmentDateTime(context),
          child: Text(
            "Đặt tư vấn",
            style: getMyTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      );
    }

    Widget _buildContent() {
      return Obx(
        () {
          if (controller.state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: CustomScrollView(
                    slivers: [
                      _buildInfoDoctor(),
                      _buildDescriptionDoctor(),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      );
    }

    return Scaffold(
      key: ObjectKey(controller),
      appBar: _buildAppBar(),
      backgroundColor: ColorsValue.primaryColor,
      body: _buildContent(),
      bottomNavigationBar: _buildButtonNavBottom(),
    );
  }
}
