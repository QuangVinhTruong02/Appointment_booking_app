import 'package:booking_doctor/admin/common/values/colors_value_web.dart';
import 'package:booking_doctor/admin/common/widgets/dialog_web.dart';
import 'package:booking_doctor/admin/common/widgets/my_button_web.dart';
import 'package:booking_doctor/admin/common/widgets/text_style_for_web.dart';
import 'package:booking_doctor/admin/common/widgets/textfield_web.dart';
import 'package:booking_doctor/admin/pages/doctor/doctor_controller.dart';
import 'package:booking_doctor/users/common/entities/doctor.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

void showDialogDoctorForm(
    {required BuildContext context,
    required bool isUpdate,
    DoctorUser? doctorUser}) {
  Widget child =
      Consumer<DoctorWebController>(builder: (context, controller, child) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Thêm bác sĩ",
              style: TextStyleWeb(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () => controller.closeDialog(context),
              icon: Icon(Icons.close),
            ),
          ],
        ),
        SizedBox(height: 15),
        Center(
          child: Material(
            child: InkWell(
              onTap: () => controller.pickImage(),
              child: isUpdate == true && !controller.state.pickedImg
                  ? Container(
                      height: 150,
                      width: 150,
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: MemoryImage(kTransparentImage),
                        image: NetworkImage(doctorUser!.photoUrl!),
                      ),
                    )
                  : controller.state.pickedImg == false &&
                          controller.state.webImage == null
                      ? Container(
                          height: 150,
                          width: 150,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.image),
                        )
                      : Container(
                          height: 150,
                          width: 150,
                          child: Image.memory(
                            controller.state.webImage!,
                            fit: BoxFit.cover,
                          ),
                        ),
            ),
          ),
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: "Email ",
                  style: TextStyleWeb(fontSize: 16),
                  children: [
                    TextSpan(
                      text: "*",
                      style: TextStyleWeb(fontSize: 16, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Material(
                child: MyTextFieldWeb(
                  readOnly: isUpdate,
                  hint: "Nhập email",
                  controller: controller.state.emailTextController,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        if (!isUpdate)
          Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: "Password ",
                    style: TextStyleWeb(fontSize: 16),
                    children: [
                      TextSpan(
                        text: "*",
                        style: TextStyleWeb(fontSize: 16, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Material(
                  child: MyTextFieldWeb(
                    hint: "Nhập password",
                    controller: controller.state.passwordTextController,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        if (!isUpdate) SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: "Họ và tên ",
                  style: TextStyleWeb(fontSize: 16),
                  children: [
                    TextSpan(
                      text: "*",
                      style: TextStyleWeb(fontSize: 16, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Material(
                child: MyTextFieldWeb(
                  hint: "Nhập họ tên",
                  controller: controller.state.userNameTextController,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: "Chuyên ngành ",
                  style: TextStyleWeb(fontSize: 16),
                  children: [
                    TextSpan(
                      text: "*",
                      style: TextStyleWeb(fontSize: 16, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Material(
                child: DropDownTextField(
                  initialValue: controller.state.majorTextController.text,
                  textFieldDecoration: InputDecoration(
                    hintText: "Chọn chuyên ngành",
                    hintStyle: TextStyleWeb(
                        fontSize: 14,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w500),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade500, width: 1.5),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorsValueWeb.secondColor, width: 1.5),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                  textStyle: TextStyleWeb(fontSize: 16),
                  enableSearch: true,
                  onChanged: (value) {
                    if (value != null) {
                      controller.state.majorTextController.text =
                          (value as DropDownValueModel).name;
                    } else {
                      controller.state.majorTextController.text = "";
                    }
                  },
                  dropDownList: controller.state.majors
                      .map(
                        (item) => DropDownValueModel(name: item, value: item),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: "Nơi công tác ",
                  style: TextStyleWeb(fontSize: 16),
                  children: [
                    TextSpan(
                      text: "*",
                      style: TextStyleWeb(fontSize: 16, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Material(
                child: DropDownTextField(
                  initialValue: controller.state.workPlaceTextController.text,
                  textFieldDecoration: InputDecoration(
                    hintText: "Chọn nơi công tác",
                    hintStyle: TextStyleWeb(
                        fontSize: 14,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w500),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade500, width: 1.5),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: ColorsValueWeb.secondColor, width: 1.5),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                  ),
                  textStyle: TextStyleWeb(fontSize: 16),
                  enableSearch: true,
                  onChanged: (value) {
                    if (value != "") {
                      controller.state.selectedHospitalId =
                          (value as DropDownValueModel).value;
                      print(controller.state.selectedHospitalId);
                      controller.state.workPlaceTextController.text =
                          (value as DropDownValueModel).name;
                    } else {
                      controller.state.selectedHospitalId = "";
                      controller.state.majorTextController.text = "";
                    }
                  },
                  dropDownList: controller.state.hospitalList
                      .map(
                        (item) => DropDownValueModel(
                            name: item.hospitalName, value: item.hospitalId),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Kinh nghiệm làm việc",
              style: TextStyleWeb(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 250,
              child: MybuttonWeb(
                isBGColors: false,
                onPressed: () => controller.addWorkExperienceController(),
                child: Row(
                  children: [
                    const Icon(
                      Icons.add,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      "Thêm kinh nghiệm làm việc",
                      style: TextStyleWeb(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.state.workProgress.length,
            itemBuilder: (context, index) {
              WorkProgressController workExperienceController =
                  controller.state.workProgress[index];
              return _buildWorkExperience(
                workExperienceController,
                context,
                index,
              );
            },
          ),
        ),
        SizedBox(height: 15),
        if (controller.state.errorMess.isNotEmpty)
          Container(
            // margin: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.zero,
            color: Colors.red.shade100,
            child: Text(
              controller.state.errorMess,
              style: TextStyleWeb(
                fontWeight: FontWeight.normal,
                color: Colors.red.shade400,
              ),
            ),
          ),
        if (controller.state.errorMess.isNotEmpty) const SizedBox(height: 15),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 150,
            child: MybuttonWeb(
              isBGColors: true,
              onPressed: () =>
                  controller.saveDoctor(context, isUpdate ? doctorUser! : null),
              child: Text(
                "Xác nhận",
                style: TextStyleWeb(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  });
  showDialogFormWeb(context, child);
}

Widget _buildWorkExperience(
  WorkProgressController workExperienceController,
  BuildContext context,
  int index,
) {
  return Column(
    children: [
      Row(
        key: Provider.of<DoctorWebController>(context, listen: false)
            .state
            .workExperienceKeys[index],
        children: [
          SizedBox(
            width: 200,
            child:
                _buildYear(workExperienceController.yearOfWorkTextController),
          ),
          Spacer(),
          Material(
            child: SizedBox(
              height: 50,
              width: 450,
              child: MyTextFieldWeb(
                  hint: "Nhập nội dung làm việc",
                  controller: workExperienceController.workAtTextController,
                  fontSize: 14),
            ),
          ),
          SizedBox(width: 10),
          IconButton(
            onPressed: () =>
                Provider.of<DoctorWebController>(context, listen: false)
                    .removeWorkExperience(index),
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      SizedBox(height: 10),
    ],
  );
}

Material _buildYear(TextEditingController textEditingController) {
  return Material(
    child: SizedBox(
      height: 50,
      child: DropDownTextField(
        initialValue: textEditingController.text,
        textStyle: TextStyleWeb(fontSize: 14),
        enableSearch: true,
        textFieldDecoration: InputDecoration(
          hintText: "Chọn năm làm việc",
          hintStyle: TextStyleWeb(
            fontSize: 14,
            color: Colors.grey.shade400,
          ),
        ),
        onChanged: (value) {
          if (value != "") {
            textEditingController.text = (value as DropDownValueModel).name;
          } else {
            textEditingController.text = "";
          }
        },
        dropDownList: [
          for (int i = 2000; i <= DateTime.now().year; i++)
            DropDownValueModel(name: "Năm ${i}", value: i)
        ],
      ),
    ),
  );
}
