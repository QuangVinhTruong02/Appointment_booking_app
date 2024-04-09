import 'dart:async';
import 'dart:io';

import 'package:booking_doctor/common/utils/invalid_exception.dart';
import 'package:booking_doctor/pages/edit_profile/doctor/index.dart';
import 'package:booking_doctor/pages/edit_profile/doctor/widget/show_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/common/service/firebase_storage.dart';
import 'package:booking_doctor/common/utils/utils.dart';
import 'package:booking_doctor/common/widgets/show_dialog.dart';
import 'package:booking_doctor/common/entities/entities.dart';
import 'package:booking_doctor/common/store/store.dart';
import 'package:booking_doctor/common/values/string_manager.dart';
import 'package:booking_doctor/common/widgets/widgets.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileDoctorController extends GetxController {
  EditProfileDoctorController();
  EditProfileDoctorState state = EditProfileDoctorState();
  final db = FirebaseFirestore.instance;

  var userNameError = "".obs;
  late DoctorUser doctorUser;
  var pickFromYear = 2000.obs;
  var pickToYear = DateTime.now().year.obs;

  late UserLoginResponse userLoginResponse;
  bool isSelectedImgAss = false;
  File? photoFile;

  @override
  void onInit() {
    super.onInit();
    userLoginResponse = UserStore.to.userLoginResponse;
    state.userNameTextController.text = userLoginResponse.userName!;
    state.photoUrl = userLoginResponse.photoUrl!;
    _generateUser();
    _binds();
  }

  _binds() {
    state.userNameTextController.addListener(() {
      setUserName(state.userNameTextController.text);
    });
  }

  _generateUser() async {
    await db
        .collection("users")
        .withConverter(
          fromFirestore: DoctorUser.fromFirestore,
          toFirestore: (userData, options) => userData.toFirestore(),
        )
        .doc(userLoginResponse.userId)
        .get()
        .then((documentSnap) {
      doctorUser = documentSnap.data()!;
      state.workPlaceController.text = doctorUser.workPlace ?? "";
      state.workExperienceList =
          List<String>.from(doctorUser.workExperience?.cast() ?? List.empty());
      state.workProgressList = List<WorkProgress>.from(
          doctorUser.workProgress?.cast() ?? List.empty());
      state.majorController.text = doctorUser.major ?? "";
      state.isLoading = false;
    });
  }

  @override
  void dispose() {
    state.userNameTextController.dispose();
    state.workExperienceController.dispose();
    state.workPlaceController.dispose();
    state.majorController.dispose();
    state.fromYearWorkProgressController.dispose();
    state.toYearWorkProgressController.dispose();
    state.workAtController.dispose();
    super.dispose();
  }

  setUserName(String value) {
    if (value.isEmpty) {
      userNameError.value = StringError.blank_space_error;
    } else {
      if (checkSpecialCharacter(value)) {
        userNameError.value = StringError.special_character_error;
      } else if (checkPhoneNumber(value)) {
        userNameError.value = StringError.phone_number_error;
      } else {
        userNameError.value = "";
      }
    }
  }

  Future pickImage(ImageSource imageSource, BuildContext context) async {
    try {
      XFile? imagePicker = await ImagePicker().pickImage(source: imageSource);
      if (imagePicker != null) {
        if (imagePicker.name.split('.')[1].contains('jpg') ||
            imagePicker.name.split('.')[1].contains('png')) {
          photoFile = File(imagePicker.path);
          state.photoUrl = imagePicker.path;
          isSelectedImgAss = true;
          Get.back();
        } else {
          throw InvalidException(message: "Dữ liệu hình ảnh không hợp lệ");
        }
      }
    } on InvalidException catch (e) {
      Get.back();
      showErrorDialog(context: context, content: e.message);
    }
  }

  bool isAllValid() {
    DoctorUser doctorUser2 = doctorUser.copyWith(
      userName: state.userNameTextController.text,
      photoUrl: state.photoUrl,
      workPlace: state.workPlaceController.text,
      // workExperience: state.workExperienceController.text,
      major: state.majorController.text,
      workExperience: state.workExperienceList,
      workProgress: state.workProgressList,
    );
    if (doctorUser2.userName!.isNotEmpty &&
        doctorUser2.workPlace!.isNotEmpty &&
        // doctorUser2.workExperience!.isNotEmpty &&
        doctorUser2.major!.isNotEmpty &&
        doctorUser2.workExperience!.isNotEmpty &&
        doctorUser2.workProgress!.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool checkObjChanges() {
    DoctorUser doctorUser2 = doctorUser.copyWith(
      userName: state.userNameTextController.text.isEmpty
          ? null
          : state.userNameTextController.text,
      photoUrl: state.photoUrl,
      workPlace: state.workPlaceController.text.isEmpty
          ? null
          : state.workPlaceController.text,
      workExperience:
          state.workExperienceList.isEmpty ? null : state.workExperienceList,
      major: state.majorController.text.isEmpty
          ? null
          : state.majorController.text,
      workProgress:
          state.workProgressList.isEmpty ? null : state.workProgressList,
    );
    if (doctorUser == doctorUser2) {
      return true;
    }
    return false;
  }

  void handleDonExitPage() {
    Get.back(canPop: false);
  }

  void handleAcceptExitPage() {
    Get.delete<EditProfileDoctorController>();
    Get.back(canPop: true);
  }

  void handleAddWorkExperience() {
    state.workExperienceList.add(state.workExperienceController.text.trim());
    state.workExperienceController.clear();
  }

  void handleChangePickFromYear(int value) {
    pickFromYear.value = value;
  }

  void handleChangePickToYear(int value) {
    pickToYear.value = value;
  }

  void handleSelectedYear() {
    state.fromYearWorkProgressController.text = pickFromYear.value.toString();
    state.toYearWorkProgressController.text = pickToYear.value.toString();
    Get.back();
  }

  void handleSaveWorkProgress(BuildContext context) {
    if (state.fromYearWorkProgressController.text.isEmpty ||
        state.toYearWorkProgressController.text.isEmpty ||
        state.workAtController.text.isEmpty) {
      showErrorDialog(context: context, content: "Điền đủ thông tin");
      return;
    }

    if (int.parse(state.fromYearWorkProgressController.text) >
        int.parse(state.toYearWorkProgressController.text)) {
      showErrorDialog(
          context: context,
          content: "Thời gian bắt đầu nhỏ hơn thời gian kết thúc");
      return;
    }
    WorkProgress workProgress = WorkProgress(
      fromYear: state.fromYearWorkProgressController.text.trim(),
      toYear: state.toYearWorkProgressController.text.trim(),
      workAt: state.workAtController.text.trim(),
    );
    state.workProgressList.add(workProgress);
    state.fromYearWorkProgressController.clear();
    state.toYearWorkProgressController.clear();
    state.workAtController.clear();
    Get.back();
  }

  void EditWorkProgress(BuildContext context, int index) {
    state.fromYearWorkProgressController.text =
        state.workProgressList[index].fromYear!;
    state.toYearWorkProgressController.text =
        state.workProgressList[index].toYear!;
    state.workAtController.text = state.workProgressList[index].workAt!;
    showAddWorkProgressDialog(context, this, isEdit: true, index: index);
  }

  void handleSaveEdit(int index) {
    if (state.fromYearWorkProgressController.text.isEmpty ||
        state.toYearWorkProgressController.text.isEmpty ||
        state.workAtController.text.isEmpty) {
      showErrorDialog(context: Get.context!, content: "Điền đủ thông tin");
      return;
    }

    if (int.parse(state.fromYearWorkProgressController.text) >
        int.parse(state.toYearWorkProgressController.text)) {
      showErrorDialog(
          context: Get.context!,
          content: "Thời gian bắt đầu nhỏ hơn thời gian kết thúc");
      return;
    }
    WorkProgress workProgress = WorkProgress(
      fromYear: state.fromYearWorkProgressController.text.trim(),
      toYear: state.toYearWorkProgressController.text.trim(),
      workAt: state.workAtController.text.trim(),
    );
    state.workProgressList[index] = workProgress;
    state.fromYearWorkProgressController.clear();
    state.toYearWorkProgressController.clear();
    state.workAtController.clear();
    Get.back();
  }

  Future handleSave(BuildContext context) async {
    showLoadingDialog(context);

    String? newPhotoUrl;
    if (photoFile != null) {
      newPhotoUrl =
          await FirebaseStorageService().uploadImg(ref: "users",file: photoFile!);
    }
    await db
        .collection("users")
        .withConverter(
          fromFirestore: DoctorUser.fromFirestore,
          toFirestore: (doctorUser, options) => doctorUser.toFirestore(),
        )
        .doc(userLoginResponse.userId)
        .update({
      if (newPhotoUrl != null) "photo_url": newPhotoUrl,
      "user_name": state.userNameTextController.text.trim(),
      "work_place": state.workPlaceController.text.trim(),
      "major": state.majorController.text.trim(),
      "work_experience": state.workExperienceList,
      "work_progress": state.workProgressList.map((e) => e.toJson()),
    }).whenComplete(() {
      UserLoginResponse newUserloginRes = userLoginResponse.copyWith(
        userName: state.userNameTextController.text.trim(),
        photoUrl: newPhotoUrl,
      );
      UserStore.to.saveProfile(newUserloginRes);
      Get.back();
      Get.back(result: newUserloginRes);
    });
  }
}
