import 'package:booking_doctor/admin/common/values/asset_value_web.dart';
import 'package:booking_doctor/admin/common/values/colors_value_web.dart';
import 'package:booking_doctor/admin/common/widgets/my_button_web.dart';
import 'package:booking_doctor/admin/common/widgets/text_style_for_web.dart';
import 'package:booking_doctor/admin/common/widgets/textfield_web.dart';
import 'package:booking_doctor/admin/pages/doctor/doctor_view.dart';
import 'package:booking_doctor/admin/pages/hospital/hospital_controller.dart';
import 'package:booking_doctor/admin/pages/hospital/widgets/show_dialog_form.dart';
import 'package:booking_doctor/users/common/entities/hospital.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class HospitalView extends StatefulWidget {
  const HospitalView({super.key});

  @override
  State<HospitalView> createState() => _HospitalViewState();
}

class _HospitalViewState extends State<HospitalView> {
  @override
  void initState() {
    super.initState();
    Provider.of<HospitalController>(context, listen: false).getHospitals();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 160,
              child: MybuttonWeb(
                isBGColors: true,
                onPressed: () {
                  showDialogHospital(context: context, isUpdate: false);
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    Text(
                      "Thêm bệnh viện",
                      style: TextStyleWeb(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              height: 50,
              width: 250,
              child: MyTextFieldWeb(
                onTap: () =>
                    Provider.of<HospitalController>(context, listen: false)
                        .filterListHospital(
                  Provider.of<HospitalController>(context, listen: false)
                      .state
                      .searchTextController
                      .text,
                ),
                onSubmitted: (value) =>
                    Provider.of<HospitalController>(context, listen: false)
                        .filterListHospital(value),
                contentPadding: EdgeInsets.all(10),
                icon: Icons.search,
                hint: "Nhập tên bệnh viện",
                controller:
                    Provider.of<HospitalController>(context, listen: false)
                        .state
                        .searchTextController,
                fontSize: 14,
                // onTap: ,
              ),
            ),
          ),
          SizedBox(height: 10),
          Consumer<HospitalController>(
            builder: (context, hospitalController, child) {
              if (hospitalController.allHospital.isNotEmpty &&
                  hospitalController.state.resultHospitals.isEmpty) {
                return Center(
                  child: Text(
                    "Không có kết quả nào được tìm kiếm",
                    style: TextStyleWeb(fontSize: 16),
                  ),
                );
              }
              return !hospitalController.state.isLoading
                  ? Table(
                      border: TableBorder.all(width: 0.1, color: Colors.grey),
                      columnWidths: {
                        0: FlexColumnWidth(3),
                        1: FlexColumnWidth(3),
                        2: FlexColumnWidth(1),
                      },
                      children: [
                        _headerTable(),
                        ..._contentTable(hospitalController),
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
      ),
    );
  }

  TableRow _headerTable() => TableRow(
        children: [
          TableCellText(
            content: "Tên bệnh viện",
            textStyle: TextStyleWeb(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          TableCellText(
            content: "Địa chỉ",
            textStyle: TextStyleWeb(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          // TableCellText(
          //   content: "Chuyên khoa",
          //   textStyle: TextStyleWeb(fontWeight: FontWeight.w500, fontSize: 16),
          // ),

          Container(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Icon(Icons.settings),
            ),
          ),
        ],
      );

  List<TableRow> _contentTable(HospitalController hospitalController) {
    return List.generate(hospitalController.state.resultHospitals.length,
        (index) {
      Hospital hospital = hospitalController.state.resultHospitals[index];
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
                        image: NetworkImage(hospital.hospitalImg!),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  hospital.hospitalName,
                  style:
                      TextStyleWeb(fontWeight: FontWeight.w400, fontSize: 14),
                ),
              ],
            ),
          ),
          TableCellText(
            content: hospital.hospitalAddress,
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
                        Icon(
                          Icons.edit,
                          size: 22,
                        ),
                        SizedBox(width: 10),
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
                        Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 22,
                        ),
                        SizedBox(width: 10),
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
                    hospitalController.setUpdateForm(hospital);
                    showDialogHospital(
                      context: context,
                      isUpdate: true,
                      hospital: hospital,
                    );
                  } else if (value == 2) {
                    hospitalController.removeHospital(index);
                  }
                },
                buttonStyleData: ButtonStyleData(
                  width: 24,
                  height: 24,
                ),
                menuItemStyleData: MenuItemStyleData(
                  height: 20,
                ),
                dropdownStyleData: DropdownStyleData(
                  width: 160,
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
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
