import 'package:booking_doctor/users/common/widgets/app_bar.dart';
import 'package:booking_doctor/users/common/widgets/my_button.dart';
import 'package:booking_doctor/users/common/widgets/my_show_modal.dart';
import 'package:booking_doctor/users/common/widgets/my_text_style.dart';
import 'package:booking_doctor/users/common/widgets/text_field.dart';
import 'package:booking_doctor/users/pages/health_record_page/health_record_form/index.dart';
import 'package:booking_doctor/users/pages/health_record_page/health_record_form/widgets/show_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HealthRecordFormPage extends GetView<HealthRecordFormController> {
  const HealthRecordFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    AppBar _buildAppbar() {
      return CustomAppBar(
        title: Text(
          controller.isEdit ? "Chỉnh sửa hồ sơ" : "Tạo hồ sơ sức khoẻ",
          style: getMyTextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        isCenterTitle: true,
      );
    }

    Widget _buildContent() {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.w),
          child: Column(
            children: [
              TextFieldObject(
                title: "Họ và tên",
                controller: controller.state.nameController,
                hint: "Nhập họ và tên",
                isMandatory: true,
              ),
              SizedBox(height: 20.w),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFieldObject(
                      title: "Ngày sinh",
                      controller: controller.state.DOBController,
                      hint: "Chọn ngày sinh",
                      isMandatory: true,
                      onTap: () {
                        selectDate(context, controller.state.DOBController);
                      },
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    flex: 1,
                    child: TextFieldObject(
                      title: "Giới tính",
                      controller: controller.state.genderController,
                      hint: "Chọn giới tính",
                      isMandatory: true,
                      onTap: () {
                        myShowModal(
                          context: context,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.w, vertical: 15.w),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Chọn giới tính",
                                  style: getMyTextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.w,
                                ),
                                ...List.generate(
                                    controller.state.checkboxObjGender.length,
                                    (index) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 5.w),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(5.w),
                                    ),
                                    child: CheckboxListTile(
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 0),
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      value: controller
                                          .state.checkboxObjGender[index].value,
                                      onChanged: (value) =>
                                          controller.onChangedCheckBoxGender(
                                              value ?? false, index),
                                      title: Text(
                                        controller.state
                                            .checkboxObjGender[index].name,
                                        style: getMyTextStyle(
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.w),
              TextFieldObject(
                title: "CMND",
                controller: controller.state.IDCardController,
                hint: "Nhập CMND",
                isMandatory: false,
              ),
              SizedBox(height: 20.w),
              TextFieldObject(
                title: "Số điện thoại",
                controller: controller.state.phoneController,
                hint: "Nhập số điện thoại",
                isMandatory: true,
                isNumberPhone: true,
              ),
              SizedBox(height: 20.w),
              TextFieldObject(
                title: "Địa chỉ",
                controller: controller.state.addressController,
                hint: "Nhập địa chỉ",
                isMandatory: true,
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildBottomBar() {
      return Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
        height: 50.w,
        padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 10.w),
        child: getMyButton(
          isBGColors: true,
          onPressed: () {
            controller.handleCreateOrUpdateHealthRecord(context);
          },
          child: Text(
            controller.isEdit ? "Chỉnh sửa" : "Tạo hồ sơ mới",
            style: getMyTextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildContent(),
      bottomNavigationBar: _buildBottomBar(),
    );
  }
}

class TextFieldObject extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hint;
  final Function()? onTap;
  final bool? isNumberPhone;
  final bool isMandatory;
  const TextFieldObject({
    super.key,
    required this.title,
    required this.controller,
    required this.hint,
    this.onTap,
    this.isNumberPhone,
    required this.isMandatory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            text: title,
            style: getMyTextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            children: [
              if (isMandatory == true)
                TextSpan(
                  text: " *",
                  style: getMyTextStyle(
                    fontSize: 16.sp,
                    color: Colors.red,
                    fontWeight: FontWeight.normal,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 10.w),
        SizedBox(
          height: 50.w,
          child: MyTextField(
            onTap: onTap,
            readOnly: onTap != null ? true : false,
            hint: hint,
            controller: controller,
            textInputType: isNumberPhone == true
                ? TextInputType.phone
                : TextInputType.text,
            isNumberPhone: isNumberPhone ?? false,
          ),
        )
      ],
    );
  }
}
