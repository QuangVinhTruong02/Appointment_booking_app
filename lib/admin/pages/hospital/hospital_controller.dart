import 'package:booking_doctor/admin/common/services/firebase_storage_web.dart';
import 'package:booking_doctor/admin/common/widgets/dialog_web.dart';
import 'package:booking_doctor/admin/pages/hospital/hospital_state.dart';
import 'package:booking_doctor/users/common/entities/hospital.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:uuid/uuid.dart';

class HospitalController extends ChangeNotifier {
  final db = FirebaseFirestore.instance;
  final state = HospitalState();
  File? photoFile;
  List<Hospital> allHospital = [];

  Future getHospitals() async {
    state.isLoading = true;
    await db
        .collection("hospitals")
        .withConverter(
          fromFirestore: Hospital.fromFirestore,
          toFirestore: (hospital, options) => hospital.toFirestore(),
        )
        .get()
        .then((value) {
      final docs = value.docs;
      state.resultHospitals = docs.map((e) => e.data()).toList();
      allHospital = state.resultHospitals;
      state.isLoading = false;
      notifyListeners();
    });
  }

  void addWorkTimeController() {
    if (state.workTimeControllers.length + 2 == 9) return;
    WorkTimeController workTimeController = WorkTimeController(
      startTime: TextEditingController()..text = "8 giờ",
      endTime: TextEditingController()..text = "17 giờ",
      day: TextEditingController()..text = "Thứ 2",
    );
    state.workTimeControllers.add(workTimeController);
    state.workTimeKeys.add(
      ObjectKey(workTimeController),
    );
    notifyListeners();
  }

  void removeWorkTime(int index) {
    state.workTimeControllers[index].day.dispose();
    state.workTimeControllers[index].startTime.dispose();
    state.workTimeControllers[index].endTime.dispose();

    state.workTimeControllers.removeAt(index);
    state.workTimeKeys.removeAt(index);
    notifyListeners();
  }

  void closeDialog(BuildContext context) {
    state.hospitalAddressTextController.clear();
    state.hospitalNameTextController.clear();
    state.workTimeControllers.clear();
    for (WorkTimeController workTimeController in state.workTimeControllers) {
      workTimeController.day.dispose();
      workTimeController.endTime.dispose();
      workTimeController.startTime.dispose();
    }
    state.webImage = null;
    state.pickedImg = false;
    state.workTimeKeys.clear();
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future pickImage() async {
    try {
      XFile? imagePicker =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (imagePicker != null) {
        var photoMemory = await imagePicker.readAsBytes();
        state.webImage = photoMemory;
        state.pickedImg = true;
        notifyListeners();
      }
    } catch (e) {
      print("error: ${e.toString()}");
    }
  }

  void setUpdateForm(Hospital hospital) {
    state.hospitalAddressTextController.text = hospital.hospitalAddress;
    state.hospitalNameTextController.text = hospital.hospitalName;
    state.workTimeControllers = hospital.workingDays.map(
      (item) {
        WorkTimeController workTimeController = WorkTimeController(
            startTime: TextEditingController()..text = item.startTime,
            endTime: TextEditingController()..text = item.endTime,
            day: TextEditingController()..text = item.day);
        state.workTimeKeys.add(
          ObjectKey(workTimeController),
        );
        return workTimeController;
      },
    ).toList();
    notifyListeners();
  }

  Future saveHospital(BuildContext context, Hospital? hospital) async {
    if (state.hospitalNameTextController.text.isEmpty) {
      state.errorMess = "Không được để tên bệnh viện trống";
      notifyListeners();
      return;
    }
    if (state.hospitalAddressTextController.text.isEmpty) {
      state.errorMess = "Không được để địa chỉ bệnh viện trống";
      notifyListeners();
      return;
    }
    if (state.webImage == null && hospital == null) {
      state.errorMess = "Không được để ảnh bệnh viện trống";
      notifyListeners();
      return;
    }
    if (state.workTimeControllers.isEmpty) {
      state.errorMess = "Chưa có ngày giờ làm việc";
      notifyListeners();
      return;
    }
    Set<String> duplicatedDay = {};
    for (WorkTimeController workTimeController in state.workTimeControllers) {
      if (workTimeController.day.text.isEmpty) {
        state.errorMess = "Ngày làm việc bị trống";
        notifyListeners();
        return;
      }

      if (duplicatedDay.contains(workTimeController.day.text)) {
        state.errorMess = "Ngày làm việc bị trùng lặp";
        notifyListeners();
        return;
      }
      if (workTimeController.startTime.text == "" ||
          workTimeController.endTime.text == "") {
        state.errorMess = "Giờ làm việc đang bị trống";
        notifyListeners();
        return;
      }
      int? endTime =
          int.tryParse(workTimeController.endTime.text.split(" ")[0]);
      int? startTime =
          int.tryParse(workTimeController.startTime.text.split(" ")[0]);
      if (endTime! - startTime! < 0) {
        state.errorMess = "Giờ kết thúc không được nhỏ hơn giờ làm việc";
        notifyListeners();
        return;
      }
      duplicatedDay.add(workTimeController.day.text);
    }

    await db
        .collection("hospitals")
        .where("hospital_name",
            isEqualTo: state.hospitalNameTextController.text)
        .where("hospital_address",
            isEqualTo: state.hospitalAddressTextController.text)
        .get()
        .then((querysnapshot) async {
      final docs = querysnapshot.docs;
      if (docs.isNotEmpty) {
        state.errorMess = "Bệnh viện này đã tồn tại";
        notifyListeners();
      } else {
        showLoadingDialogWeb(context);
        String photoUrl = "";
        if (hospital == null) {
          photoUrl = await FirebaseStorageWebService()
              .uploadImg(ref: "hospitals", unit8List: state.webImage!);
        }

        Uuid uuid = Uuid();

        var uuidV1 = hospital == null ? uuid.v1() : hospital.hospitalId;
        Hospital hospital_2 = Hospital(
          hospitalId: uuidV1,
          hospitalImg: photoUrl.isNotEmpty ? photoUrl : hospital!.hospitalImg,
          hospitalName: state.hospitalNameTextController.text,
          hospitalAddress: state.hospitalAddressTextController.text,
          workingDays: state.workTimeControllers
              .map(
                (e) => WorkingDay(
                  startTime: e.startTime.text,
                  endTime: e.endTime.text,
                  day: e.day.text,
                ),
              )
              .toList(),
          createdAt: hospital == null ? Timestamp.now() : hospital.createdAt,
        );
        db
            .collection("hospitals")
            .doc(uuidV1)
            .withConverter(
              fromFirestore: Hospital.fromFirestore,
              toFirestore: (hospital, options) => hospital.toFirestore(),
            )
            .set(hospital_2);
        state.errorMess = "";
        if (hospital == null) {
          state.resultHospitals.insert(0, hospital_2);
          allHospital = state.resultHospitals;
        } else {
          int index = state.resultHospitals.indexWhere(
              (element) => element.hospitalId == hospital.hospitalId);
          state.resultHospitals[index] = hospital_2;
          allHospital[index] = hospital_2;
        }

        state.hospitalAddressTextController.clear();
        state.hospitalNameTextController.clear();
        state.workTimeControllers.clear();
        state.workTimeKeys.clear();

        state.webImage = null;
        state.pickedImg = false;
        Navigator.of(context, rootNavigator: true)
            .popUntil((route) => route.isFirst);
        notifyListeners();
      }
    });
  }

  void removeHospital(int index) {
    Hospital hospital = state.resultHospitals[index];
    db.collection("hospitals").doc(hospital.hospitalId).delete();
    String photoUrl = hospital.hospitalImg!;
    FirebaseStorageWebService().deleteStorageById(
      photoUrl,
      "hospitals",
    );
    state.resultHospitals.removeAt(index);
    allHospital.removeAt(index);
    notifyListeners();
  }

  void filterListHospital(String value) {
    if (value.isEmpty) {
      state.resultHospitals = allHospital;
    } else {
      state.resultHospitals = allHospital
          .where((element) =>
              element.hospitalName.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }
}

class WorkTimeController {
  final TextEditingController day;
  final TextEditingController startTime;
  final TextEditingController endTime;
  WorkTimeController(
      {required this.startTime, required this.endTime, required this.day});
}
