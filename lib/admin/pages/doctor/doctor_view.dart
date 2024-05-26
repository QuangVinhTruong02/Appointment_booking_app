import 'package:booking_doctor/admin/common/values/asset_value_web.dart';
import 'package:booking_doctor/admin/common/values/colors_value_web.dart';
import 'package:booking_doctor/admin/common/widgets/my_button_web.dart';
import 'package:booking_doctor/admin/common/widgets/text_style_for_web.dart';
import 'package:booking_doctor/admin/common/widgets/textfield_web.dart';
import 'package:booking_doctor/admin/pages/doctor/doctor_controller.dart';
import 'package:booking_doctor/admin/pages/doctor/widgets/show_dialog_form.dart';
import 'package:booking_doctor/users/common/entities/doctor.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class DoctorWebView extends StatefulWidget {
  const DoctorWebView({super.key});

  @override
  State<DoctorWebView> createState() => _DoctorWebViewState();
}

class _DoctorWebViewState extends State<DoctorWebView> {
  @override
  void initState() {
    super.initState();
    Provider.of<DoctorWebController>(context, listen: false).getDoctors();
    Provider.of<DoctorWebController>(context, listen: false).getMajors();
    Provider.of<DoctorWebController>(context, listen: false).getHospital();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            width: 150,
            child: MybuttonWeb(
              isBGColors: true,
              onPressed: () {
                showDialogDoctorForm(context: context, isUpdate: false);
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  Text(
                    "Thêm bác sĩ",
                    style: TextStyleWeb(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Align(
          alignment: Alignment.centerRight,
          child: SizedBox(
            height: 50,
            width: 250,
            child: MyTextFieldWeb(
              onTap: () => Provider.of<DoctorWebController>(context,
                      listen: false)
                  .filterListHospital(
                      Provider.of<DoctorWebController>(context, listen: false)
                          .state
                          .searchTextController
                          .text),
              onSubmitted: (value) =>
                  Provider.of<DoctorWebController>(context, listen: false)
                      .filterListHospital(value),
              contentPadding: EdgeInsets.all(10),
              icon: Icons.search,
              hint: "Nhập tên bác sĩ, nơi làm việc",
              controller:
                  Provider.of<DoctorWebController>(context, listen: false)
                      .state
                      .searchTextController,
              fontSize: 14,
              // onTap: ,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Consumer<DoctorWebController>(
          builder: (context, doctorWebController, child) {
            return !doctorWebController.state.isLoading
                ? Table(
                    border: TableBorder.all(width: 0.1, color: Colors.grey),
                    columnWidths: const {
                      0: FlexColumnWidth(3),
                      1: FlexColumnWidth(3),
                      2: FlexColumnWidth(3),
                      3: FlexColumnWidth(3),
                      4: FlexColumnWidth(1),
                    },
                    children: [
                      _headerTable(),
                      ..._contentTable(doctorWebController),
                    ],
                  )
                : Center(
                    child: CircularProgressIndicator(
                      color: ColorsValueWeb.secondColor,
                    ),
                  );
          },
        ),
      ],
    );
  }

  TableRow _headerTable() => TableRow(
        children: [
          TableCellText(
            content: "Họ và tên",
            textStyle: TextStyleWeb(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          TableCellText(
            content: "Email",
            textStyle: TextStyleWeb(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          TableCellText(
            content: "Chuyên khoa",
            textStyle: TextStyleWeb(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          TableCellText(
            content: "Nơi làm việc",
            textStyle: TextStyleWeb(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          Container(
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.settings),
            ),
          ),
        ],
      );

  List<TableRow> _contentTable(DoctorWebController doctorWebController) {
    return List.generate(doctorWebController.state.resultDoctors.length,
        (index) {
      DoctorUser doctorUser = doctorWebController.state.resultDoctors[index];
      return TableRow(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Center(
                  child: ClipOval(
                    child: Container(
                      width: 50,
                      height: 50,
                      color: Colors.grey[300],
                      child: FadeInImage(
                        fit: BoxFit.cover,
                        placeholder: MemoryImage(kTransparentImage),
                        image: NetworkImage(doctorUser.photoUrl!),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  doctorUser.userName!,
                  style:
                      TextStyleWeb(fontWeight: FontWeight.w400, fontSize: 14),
                ),
              ],
            ),
          ),
          TableCellText(
            content: doctorUser.email!,
            textStyle: TextStyleWeb(fontWeight: FontWeight.w400, fontSize: 14),
          ),
          TableCellText(
            content: doctorUser.major!,
            textStyle: TextStyleWeb(fontWeight: FontWeight.w400, fontSize: 14),
          ),
          TableCellText(
            content: doctorUser.hospitalName!,
            textStyle: TextStyleWeb(fontWeight: FontWeight.w400, fontSize: 14),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2<int>(
                customButton: SvgPicture.asset(AssetSvgWebValue.dots_vertical),
                items: [
                  DropdownMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.edit,
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "Chỉnh sửa",
                            style: TextStyleWeb(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 22,
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: Text(
                            "Xoá",
                            style: TextStyleWeb(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value == 1) {
                    // Thực hiện hành động chỉnh sửa
                    doctorWebController.setUpdateForm(doctorUser);
                    showDialogDoctorForm(
                        context: context,
                        isUpdate: true,
                        doctorUser: doctorUser);
                  } else if (value == 2) {
                    doctorWebController.removeDoctor(index);
                  }
                },
                buttonStyleData: const ButtonStyleData(
                  width: 24,
                  height: 24,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 20,
                ),
                dropdownStyleData: DropdownStyleData(
                  // maxHeight: 80,
                  width: 160,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),
                  offset: const Offset(0, 8),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class TableCellText extends StatelessWidget {
  final String content;
  final TextStyle textStyle;
  const TableCellText(
      {super.key, required this.content, required this.textStyle});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          content,
          style: textStyle,
        ),
      ),
    );
  }
}
