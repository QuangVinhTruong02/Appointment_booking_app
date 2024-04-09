import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:booking_doctor/common/entities/entities.dart';
import 'package:booking_doctor/common/service/service.dart';
import 'package:booking_doctor/common/state_rerender/freezed_data_classes.dart';
import 'package:booking_doctor/common/store/store.dart';
import 'package:booking_doctor/common/utils/utils.dart';
import 'package:booking_doctor/common/widgets/widgets.dart';
import 'package:booking_doctor/common/values/values.dart';
import 'package:booking_doctor/common/routes/routes.dart';
import 'package:booking_doctor/pages/sign_in/index.dart';

class SignInController extends GetxController {
  final db = FirebaseFirestore.instance;
  final SignInState state = SignInState();

  var loginObj = LoginObject("", "");

  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputValidStreamController =
      StreamController<void>.broadcast();

  @override
  void dispose() {
    _emailStreamController.close();
    _passwordStreamController.close();
    _isAllInputValidStreamController.close();
    state.emailTextController.dispose();
    state.passwordTextController.dispose();
    state.forgotPasswordController.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();

    _bind();
  }

  _bind() {
    state.emailTextController
        .addListener(() => setEmail(state.emailTextController.text));
    state.passwordTextController
        .addListener(() => setPassword(state.passwordTextController.text));
  }

  setEmail(String email) {
    _emailStreamController.sink.add(email);
    if (_isEmailValid(email)) {
      loginObj = loginObj.copyWith(email: email.trim());
    } else {
      loginObj = loginObj.copyWith(email: "");
    }
    _validate();
  }

  setPassword(String password) {
    _passwordStreamController.sink.add(password);
    if (_isPassword(password)) {
      loginObj = loginObj.copyWith(password: password.trim());
    } else {
      loginObj = loginObj.copyWith(password: "");
    }
    _validate();
  }

  bool _isEmailValid(String email) {
    return isEmail(email);
  }

  bool _isPassword(String password) {
    return isLength(password);
  }

  bool _validateAllInput() {
    return loginObj.email.isNotEmpty && loginObj.password.isNotEmpty;
  }

  _validate() {
    _isAllInputValidStreamController.sink.add(null);
  }

  Future<void> handleSignInWithGoogle(BuildContext context) async {
    try {
      showLoadingDialog(context);
      var user = await googleSignIn.signIn();
      if (user != null) {
        OAuthCredential oAuthCredential =
            await FirebaseAuthService().openGoogleSignIn(user);
        UserCredential userCredential =
            await FirebaseAuthService().loginWithGoogleSignIn(oAuthCredential);
        String userName = user.displayName ?? user.email;
        String email = user.email;
        String id = userCredential.user!.uid;
        String photoUrl = user.photoUrl ??
            await FirebaseStorageService()
                .getDefaultImgUrl("users", "avt_default.png");
        await db
            .collection("users")
            .where("email", isEqualTo: email)
            // .withConverter(
            //   fromFirestore: PatientUser.fromFirestore,
            //   toFirestore: (userData, options) => userData.toFirestore(),
            // )
            .get()
            .then((querySnapshot) async {
          final docs = querySnapshot.docs;
          if (docs.isEmpty) {
            PatientUser? userData;
            userData = PatientUser(
              userId: id,
              email: email,
              userName: userName,
              photoUrl: photoUrl,
            );
            await db
                .collection("users")
                .withConverter(
                  fromFirestore: PatientUser.fromFirestore,
                  toFirestore: (userData, options) => userData.toFirestore(),
                )
                .doc(userData.userId)
                .set(userData);
            UserLoginResponse userLoginResponse = UserLoginResponse(
              email: email,
              userId: id,
              photoUrl: userData.photoUrl,
              userName: userData.userName,
            );
            UserStore.to.saveProfile(userLoginResponse);
            toastInfo(msg: StringValue.loginSuccess);
            Get.offAllNamed(AppRoutes.APPLICATION);
          } else {
            final doc = docs.first;
            print("check role: ${doc['role']}");
            final role = doc.data()['role'];
            UserLoginResponse userLoginResponse = _login(doc, role);
            UserStore.to.saveProfile(userLoginResponse);
            toastInfo(msg: StringValue.loginSuccess);
            Get.offAllNamed(AppRoutes.APPLICATION);
          }
        });
      } else {
        Get.back();
      }

      // }
    } catch (e) {
      print("Error: ${e}");
      toastInfo(msg: e.toString());
    }
  }

  Future<void> handleSignIn(BuildContext context) async {
    showLoadingDialog(context);
    AuthResultStatus status =
        await FirebaseAuthService().loginWithEmailPassword(
      email: loginObj.email.trim(),
      password: loginObj.password.trim(),
    );
    if (status == AuthResultStatus.successful) {
      await db
          .collection("users")
          .where("email", isEqualTo: loginObj.email)
          // .withConverter(
          //   fromFirestore: PatientUser.fromFirestore,
          //   toFirestore: (userdata, options) => userdata.toFirestore(),
          // )
          .get()
          .then(
        (querySnapshot) {
          final doc = querySnapshot.docs.first;
          final role = doc.data()['role'];
          UserLoginResponse userLoginResponse = _login(doc, role);

          toastInfo(msg: StringValue.loginSuccess);
          UserStore.to.saveProfile(userLoginResponse);
          Get.offAllNamed(AppRoutes.APPLICATION);
        },
      );
    } else {
      Get.back();
      toastInfo(msg: AuthExceptionHandle.generateExceptionMessage(status));
    }
  }

  UserLoginResponse _login(
      DocumentSnapshot<Map<String, dynamic>> doc, String role) {
    UserLoginResponse userLoginResponse;
    if (role == Role.Patient.toString().split('.')[1]) {
      PatientUser patientUser = PatientUser.fromFirestore(doc, null);
      print(patientUser.DOB);
      userLoginResponse = UserLoginResponse(
        email: patientUser.email,
        userId: patientUser.userId,
        photoUrl: patientUser.photoUrl,
        userName: patientUser.userName,
        role: patientUser.role,
      );
    } else {
      DoctorUser doctorUser = DoctorUser.fromFirestore(doc, null);
      userLoginResponse = UserLoginResponse(
        email: doctorUser.email,
        userId: doctorUser.userId,
        photoUrl: doctorUser.photoUrl,
        userName: doctorUser.userName,
        role: doctorUser.role,
      );
    }
    return userLoginResponse;
  }

  void handleDontHaveAccount() {
    Get.offNamed(AppRoutes.SIGN_UP);
  }

  void handleForgotPassword() {
    Get.toNamed(AppRoutes.FORGOT_PASSWORD);
  }

  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));
  Stream<bool> get outputIsPassword =>
      _passwordStreamController.stream.map((password) => _isPassword(password));
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputValidStreamController.stream
          .map((event) => _validateAllInput());
}
