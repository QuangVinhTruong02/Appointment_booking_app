import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/common/entities/entities.dart';
import 'package:booking_doctor/common/routes/routes.dart';
import 'package:booking_doctor/common/service/service.dart';
import 'package:booking_doctor/common/store/store.dart';
import 'package:booking_doctor/common/values/string_manager.dart';
import 'package:booking_doctor/common/values/values.dart';
import 'package:booking_doctor/common/widgets/show_dialog.dart';
import 'package:booking_doctor/common/widgets/toast.dart';
import 'package:booking_doctor/pages/profile/index.dart';

class ProfileController extends GetxController {
  ProfileController();

  final db = FirebaseFirestore.instance;
  final state = ProfileState();
  var _userLoginResponse = UserLoginResponse().obs;

  @override
  void onInit() {
    super.onInit();
    // _getUserData();
    _userLoginResponse.value = UserStore.to.userLoginResponse;
  }

  // _getUserData() async {
  //   await db
  //       .collection("users")
  //       .doc(userLoginResponse.id)
  //       .withConverter(
  //         fromFirestore: UserData.fromFirestore,
  //         toFirestore: (userData, options) => userData.toFirestore(),
  //       )
  //       .get()
  //       .then((document) {
  //     state.userData.value = document.data()!;
  //   });
  // }

  Future handleNavigationEdit() async {
    bool isPatient = UserStore.to.userLoginResponse.role ==
        Role.Patient.toString().split('.')[1];
    await Get.toNamed(isPatient
            ? AppRoutes.EDIT_PROFILE_PATIENT
            : AppRoutes.EDIT_PROFILE_DOCTOR)
        ?.then((newUserLoginRes) {
      if (newUserLoginRes != null) {
        _userLoginResponse.value = newUserLoginRes;
      }
    });
  }

  Future handleSignOut(BuildContext context) async {
    showQuestionDialog(
      context: context,
      title: StringTitleDia.logout,
      lottieAsset: AssetJsonValue.log_out,
      onTapSubmit: () async {
        await googleSignIn.signOut();
        await FirebaseAuth.instance.signOut();
        await UserStore.to.onLogout().then((_) {
          toastInfo(msg: StringValue.logout_successful);
          Get.offAllNamed(AppRoutes.SIGN_IN);
        });
      },
      onTapCancel: () => Get.back(),
    );
  }

  UserLoginResponse get userLoginResponse => _userLoginResponse.value;
}
