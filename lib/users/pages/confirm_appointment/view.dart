import 'package:booking_doctor/users/common/utils/date.dart';
import 'package:booking_doctor/users/common/values/colors_value.dart';
import 'package:booking_doctor/users/common/widgets/app_bar.dart';
import 'package:booking_doctor/users/common/widgets/my_button.dart';
import 'package:booking_doctor/users/common/widgets/my_text_style.dart';
import 'package:booking_doctor/users/pages/confirm_appointment/index.dart';
import 'package:booking_doctor/users/pages/confirm_appointment/widget/show_health_record_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ConfirmAppointmentPage extends GetView<ConfirmAppointmentController> {
  const ConfirmAppointmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppBar() {
      return CustomAppBar(
        isCenterTitle: true,
        title: Text(
          "Đặt lịch tư vấn",
          style: getMyTextStyle(
            fontSize: 20.sp,
            color: ColorsValue.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    Widget _buildContent() {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Thông tin đặt lịch",
                    style: getMyTextStyle(
                      fontSize: 16.sp,
                      color: ColorsValue.secondColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CardItem(
                      icon: Icons.person_add,
                      title: "Bác sĩ",
                      subTitle: Text(
                        controller.state.doctor.userName!,
                        style: getMyTextStyle(fontSize: 16.sp),
                      )),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey.shade300,
                  ),
                  CardItem(
                      icon: Icons.health_and_safety,
                      title: "Chuyên khoa",
                      subTitle: Text(
                        controller.state.doctor.major!,
                        style: getMyTextStyle(fontSize: 16.sp),
                      )),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey.shade300,
                  ),
                  CardItem(
                      icon: Icons.location_on,
                      title: "Bệnh viện",
                      subTitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.state.doctor.hospitalName!,
                            style: getMyTextStyle(fontSize: 16.sp),
                          ),
                          SizedBox(height: 5.w),
                          Text(
                            "Đ/C: ${controller.state.doctor.hospitalAddress!}",
                            style: getMyTextStyle(fontSize: 16.sp),
                          ),
                        ],
                      )),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey.shade300,
                  ),
                  CardItem(
                    icon: Icons.calendar_month,
                    title: "Ngày hẹn",
                    subTitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 5.w,
                              ),
                              decoration: BoxDecoration(
                                color: ColorsValue.secondColor.withOpacity(0.7),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.white,
                                    size: 16.r,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    formatDate(controller.state.selectedDate),
                                    style: getMyTextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (controller.state.selectedTime.isNotEmpty)
                              SizedBox(width: 10.w),
                            if (controller.state.selectedTime.isNotEmpty)
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 5.w,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      ColorsValue.secondColor.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.timer_outlined,
                                      color: Colors.white,
                                      size: 16.r,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      controller.state.selectedTime,
                                      style: getMyTextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 5.w),
                        Text(
                          "Giá khám: ${formatCurrency(100000)}",
                          style: getMyTextStyle(
                            fontSize: 16.sp,
                            color: Colors.blue,
                          ),
                        ),
                        SizedBox(height: 5.w),
                        Text(
                          "Thanh toán tại quầy",
                          style: getMyTextStyle(
                            fontSize: 16.sp,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey.shade300,
                  ),
                  InkWell(
                    onTap: controller.healthRecordId.isEmpty
                        ? () {
                            controller.getHealthRecord();
                            showHealthRecordBottomSheet(context);
                          }
                        : null,
                    child: CardItem(
                      icon: Icons.fact_check_outlined,
                      title: "Hồ sơ sức khoẻ",
                      subTitle: Obx(
                        () {
                          if (controller.state.healthRecord != null) {
                            return Text(
                              "Hồ sơ của ${controller.state.healthRecord?.userName ?? ""}",
                              style: getMyTextStyle(fontSize: 16.sp),
                            );
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Chưa có hồ sơ sức khỏe",
                                  style: getMyTextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.grey.shade400),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.grey.shade400,
                                  size: 16.r,
                                )
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 0.5,
                    color: Colors.grey.shade300,
                  ),
                  TextField(
                    // onTap: () => controller.handleScroll(),
                    style: getMyTextStyle(fontSize: 16.sp),
                    minLines: 1,
                    maxLines: 3,
                    controller: controller.state.symptomTextController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      hintText: "Nhập Lý do khám (Lý do khám, triệu chứng...)",
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: getMyTextStyle(
                          fontSize: 16.sp, color: Colors.grey.shade400),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
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
        child: getMyButton(
          isBGColors: true,
          onPressed: () => controller.handleSubmit(context),
          child: Text(
            "Xác nhận",
            style: getMyTextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget subTitle;
  const CardItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(
          icon,
          color: ColorsValue.secondColor,
          size: 20.w,
        ),
        title: Padding(
          padding: EdgeInsets.only(bottom: 10.w),
          child: Text(
            title,
            style: getMyTextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        subtitle: subTitle);
  }
}
