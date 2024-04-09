import 'dart:async';
import 'dart:io';

import 'package:booking_doctor/pages/edit_profile/patient/state.dart';
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

enum Sexual { Male, Female }

class EditProfilePatientController extends GetxController {
  EditProfilePatientController();
  EditProfilePatientState state = EditProfilePatientState();
  final db = FirebaseFirestore.instance;

  var userNameError = "".obs;
  var phoneNumberError = "".obs;
  late PatientUser userData;

  late UserLoginResponse userLoginResponse;
  bool isSelectedImgAss = false;
  File? photoFile;

  @override
  void onInit() {
    super.onInit();
    userLoginResponse = UserStore.to.userLoginResponse;
    state.userNameTextController.text = userLoginResponse.userName!;
    state.photoUrl = userLoginResponse.photoUrl!;
    print("loading: ${state.isLoading}");
    _generateUser();
    _binds();
  }

  _binds() {
    state.userNameTextController.addListener(() {
      setUserName(state.userNameTextController.text);
    });

    state.phoneNumberController.addListener(() {
      setPhoneNumber(state.phoneNumberController.text);
    });
  }

  _generateUser() async {
    await db
        .collection("users")
        .withConverter(
          fromFirestore: PatientUser.fromFirestore,
          toFirestore: (userData, options) => userData.toFirestore(),
        )
        .doc(userLoginResponse.userId)
        .get()
        .then((documentSnap) {
      userData = documentSnap.data()!;

      state.DOBController.text = userData.DOB ?? "";
      state.phoneNumberController.text = userData.phoneNumber ?? "";
      if (userData.sexual != null) {
        state.sexual = userData.sexual == Sexual.Male.toString().split('.')[1]
            ? Sexual.Male
            : Sexual.Female;
      }
      state.isLoading = false;
    }).whenComplete(() {});
  }

  @override
  void dispose() {
    state.userNameTextController.dispose();
    state.DOBController.dispose();
    state.phoneNumberController.dispose();
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

  setPhoneNumber(String value) {
    if (value.isEmpty) {
      phoneNumberError.value = StringError.blank_space_error;
    } else {
      if (checkSpecialCharacter(value)) {
        phoneNumberError.value = StringError.special_character_error;
      } else if (value.length != 10) {
        phoneNumberError.value = StringError.must_not_exactly_length;
      } else {
        phoneNumberError.value = "";
      }
    }
  }

  Future pickImage(ImageSource imageSource) async {
    try {
      XFile? imagePicker = await ImagePicker().pickImage(source: imageSource);
      if (imagePicker != null) {
        photoFile = File(imagePicker.path);
        state.photoUrl = imagePicker.path;
        isSelectedImgAss = true;
        Get.back();
      }
    } catch (e) {
      print("error: ${e.toString()}");
    }
  }

  bool isAllValid() {
    PatientUser userData2 = userData.copyWith(
        userName: state.userNameTextController.text,
        photoUrl: state.photoUrl,
        sexual: state.sexual.toString(),
        DOB: state.DOBController.text,
        phoneNumber: state.phoneNumberController.text);
    if (userData2.userName!.isNotEmpty &&
        userData2.sexual!.isNotEmpty &&
        userData2.DOB!.isNotEmpty &&
        userData2.phoneNumber!.isNotEmpty) {
      return true;
    }
    return false;
  }

  bool checkObjChanges() {
    PatientUser userData2 = userData.copyWith(
      userName: state.userNameTextController.text.isEmpty
          ? null
          : state.userNameTextController.text,
      photoUrl: state.photoUrl,
      sexual:
          state.sexual == null ? null : state.sexual.toString().split('.')[1],
      DOB: state.DOBController.text.isEmpty ? null : state.DOBController.text,
      phoneNumber: state.phoneNumberController.text.isEmpty
          ? null
          : state.phoneNumberController.text,
    );
    if (userData == userData2) {
      return true;
    }
    return false;
  }

  void handleDonExitPage() {
    Get.back(canPop: false);
  }

  void handleAcceptExitPage() {
    Get.delete<EditProfilePatientController>();
    Get.back(canPop: true);
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
          fromFirestore: PatientUser.fromFirestore,
          toFirestore: (userData, options) => userData.toFirestore(),
        )
        .doc(userLoginResponse.userId)
        .update({
      if (newPhotoUrl != null) "photo_url": newPhotoUrl,
      "user_name": state.userNameTextController.text.trim(),
      "sexual": state.sexual == Sexual.Male ? "Male" : "Female",
      "DOB": state.DOBController.text.trim(),
      "phone_number": state.phoneNumberController.text.trim(),
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
