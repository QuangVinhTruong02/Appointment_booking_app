import 'package:booking_doctor/pages/edit_profile/doctor/controller.dart';
import 'package:booking_doctor/pages/edit_profile/patient/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:booking_doctor/common/values/values.dart';
import 'package:booking_doctor/common/widgets/widgets.dart';
import 'package:lottie/lottie.dart';

showPickImageModal(BuildContext context,
    {EditProfilePatientController? patientController,
    EditProfileDoctorController? doctorController}) {
  return myShowModal(
    context: context,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(Icons.camera_alt_outlined),
          title: Text(
            StringValue.camera,
            style: getMyTextStyle(),
          ),
          onTap: () => patientController != null
              ? patientController.pickImage(ImageSource.camera)
              : doctorController!.pickImage(ImageSource.camera, context),
        ),
        SizedBox(height: 10.h),
        ListTile(
          leading: Icon(Icons.photo_library_outlined),
          title: Text(
            StringValue.gallery,
            style: getMyTextStyle(),
          ),
          onTap: () => patientController != null
              ? patientController.pickImage(ImageSource.gallery)
              : doctorController!.pickImage(ImageSource.gallery, context),
        ),
      ],
    ),
  );
}

Future<bool> showExitpageDialog(BuildContext context,
    {EditProfilePatientController? patientController,
    EditProfileDoctorController? doctorController}) async {
  if (patientController != null
      ? !patientController.checkObjChanges()
      : !doctorController!.checkObjChanges()) {
    bool? value;
    await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.r),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 100,
                width: 100,
                child: Lottie.asset(
                  AssetJsonValue.warning,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                StringTitleDia.discard_changes,
                style: getMyTextStyle(
                    fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
              child: getMyButton(
                isBGColors: false,
                onPressed: () {
                  patientController != null
                      ? patientController.handleDonExitPage()
                      : doctorController!.handleDonExitPage();
                  value = false;
                },
                child: Text(
                  StringContentDia.no,
                  style: getMyTextStyle(fontSize: 16.sp),
                ),
                isBorderSide: true,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
              child: getMyButton(
                isBGColors: true,
                onPressed: () {
                  patientController != null
                      ? patientController.handleAcceptExitPage()
                      : doctorController!.handleAcceptExitPage();
                  value = true;
                },
                child: Text(
                  StringContentDia.accept,
                  style: getMyTextStyle(color: Colors.white, fontSize: 16.sp),
                ),
              ),
            ),
          ],
        );
      },
    );
    if (value != null) {
      return Future.value(value);
    } else {
      return true;
    }
  } else {
    return true;
  }
}

Future<void> selectDate(
    BuildContext context, EditProfilePatientController controller) async {
  DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2025),
  );

  if (picked != null) {
    controller.state.DOBController.text = picked.toString().split(" ")[0];
  }
}
