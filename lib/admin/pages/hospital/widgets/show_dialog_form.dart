import 'package:booking_doctor/admin/common/widgets/dialog_web.dart';
import 'package:booking_doctor/admin/common/widgets/my_button_web.dart';
import 'package:booking_doctor/admin/common/widgets/text_style_for_web.dart';
import 'package:booking_doctor/admin/common/widgets/textfield_web.dart';
import 'package:booking_doctor/admin/pages/hospital/hospital_controller.dart';
import 'package:booking_doctor/users/common/entities/hospital.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

void showDialogHospital(
    {required BuildContext context,
    Hospital? hospital,
    required bool isUpdate}) {
  Widget child =
      Consumer<HospitalController>(builder: (context, controller, child) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              !isUpdate
                  ? "Thêm thông tin bệnh viện"
                  : "Sửa thông tin bệnh viện",
              style: TextStyleWeb(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            IconButton(
              onPressed: () => controller.closeDialog(context),
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        const SizedBox(height: 15),
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
                        image: NetworkImage(hospital!.hospitalImg!),
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
        // Text(data)
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: Text(
                "Tên bệnh viện:",
                style: TextStyleWeb(fontSize: 16),
              ),
            ),
            Expanded(
              child: Material(
                child: MyTextFieldWeb(
                  hint: "Nhập tên bệnh viện",
                  controller: controller.state.hospitalNameTextController,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: Text(
                "Địa chỉ:",
                style: TextStyleWeb(fontSize: 16),
              ),
            ),
            Expanded(
              child: Material(
                child: MyTextFieldWeb(
                  hint: "Nhập địa chỉ",
                  controller: controller.state.hospitalAddressTextController,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
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

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Ngày giờ làm việc:",
              style: TextStyleWeb(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 250,
                child: MybuttonWeb(
                  isBGColors: false,
                  onPressed: () => controller.addWorkTimeController(),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Thêm ngày làm việc",
                        style: TextStyleWeb(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.state.workTimeControllers.length,
            itemBuilder: (context, index) {
              WorkTimeController workTimeController =
                  controller.state.workTimeControllers[index];
              return _buildWorkTime(
                workTimeController,
                context,
                index,
              );
            },
          ),
        ),
        const SizedBox(height: 15),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 150,
            child: MybuttonWeb(
              isBGColors: true,
              onPressed: () =>
                  Provider.of<HospitalController>(context, listen: false)
                      .saveHospital(context, isUpdate ? hospital : null),
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

Widget _buildWorkTime(
  WorkTimeController workTimeController,
  BuildContext context,
  int index,
) {
  return Row(
    key: Provider.of<HospitalController>(context, listen: false)
        .state
        .workTimeKeys[index],
    children: [
      Expanded(
        flex: 1,
        child: SizedBox(width: 60, child: _buildDay(workTimeController.day)),
      ),
      const SizedBox(width: 50),
      Text(
        ":",
        style: TextStyleWeb(fontSize: 16),
      ),
      const SizedBox(width: 50),
      Expanded(
        flex: 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _buildTime(workTimeController.startTime),
            ),
            Expanded(
              child: Center(
                child: Text(
                  "--",
                  style: TextStyleWeb(),
                ),
              ),
            ),
            Expanded(child: _buildTime(workTimeController.endTime)),
            Expanded(
              child: IconButton(
                onPressed: () =>
                    Provider.of<HospitalController>(context, listen: false)
                        .removeWorkTime(index),
                icon: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      )
    ],
  );
}

Material _buildDay(TextEditingController textEditingController) {
  return Material(
    child: SizedBox(
      height: 50,
      child: DropDownTextField(
        initialValue: textEditingController.text,
        textStyle: TextStyleWeb(fontSize: 16),
        enableSearch: true,
        textFieldDecoration: InputDecoration(
          hintText: "Chọn ngày",
          hintStyle: TextStyleWeb(
            fontSize: 16,
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
          for (int i = 2; i < 9; i++)
            DropDownValueModel(name: i == 8 ? "Chủ nhật" : "Thứ ${i}", value: i)
        ],
      ),
    ),
  );
}

Material _buildTime(TextEditingController textEditingController) {
  return Material(
    child: SizedBox(
      height: 50,
      child: DropDownTextField(
        initialValue: textEditingController.text,
        textStyle: TextStyleWeb(fontSize: 16),
        enableSearch: true,
        onChanged: (value) {
          if (value != "") {
            textEditingController.text = (value as DropDownValueModel).name;
          } else {
            textEditingController.text = "";
          }
        },
        dropDownList: List.generate(
          24,
          (index) =>
              DropDownValueModel(name: "${index.toString()} giờ", value: index),
        ),
      ),
    ),
  );
}
