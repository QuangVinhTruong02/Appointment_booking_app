import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:booking_doctor/common/entities/entities.dart';
import 'package:booking_doctor/common/service/service.dart';
import 'package:booking_doctor/common/state_rerender/freezed_data_classes.dart';
import 'package:booking_doctor/common/store/store.dart';
import 'package:booking_doctor/common/utils/utils.dart';
import 'package:booking_doctor/common/widgets/widgets.dart';
import 'package:booking_doctor/pages/sign_up/index.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:booking_doctor/common/routes/routes.dart';

class SignUpController extends GetxController {
  SignUpController();
  SignUpState state = SignUpState();
  var registerObj = RegisterObject("", "", "", "");

  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  FocusNode _focusNode = FocusNode();
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _confirmPasswordStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputValidStreamController =
      StreamController<void>.broadcast();
  @override
  void dispose() {
    _emailStreamController.close();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _confirmPasswordStreamController.close();
    _isAllInputValidStreamController.close();
    state.emailTextController.dispose();
    state.userNameTextController.dispose();
    state.passwordTextController.dispose();
    state.confirmPasswordTextController.dispose();
    state.pinController.dispose();
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
    state.userNameTextController
        .addListener(() => setUserName(state.userNameTextController.text));
    state.passwordTextController
        .addListener(() => setPassword(state.passwordTextController.text));
    state.confirmPasswordTextController.addListener(
        () => setConfirmPassword(state.confirmPasswordTextController.text));
  }

  //set valid
  setEmail(String email) {
    _emailStreamController.sink.add(email);
    if (_isEmailValid(email)) {
      registerObj = registerObj.copyWith(email: email.trim());
    } else {
      registerObj = registerObj.copyWith(email: "");
    }
    _validate();
  }

  setUserName(String userName) {
    _userNameStreamController.sink.add(userName);
    if (_isUserName(userName)) {
      registerObj = registerObj.copyWith(userName: userName.trim());
    } else {
      registerObj = registerObj.copyWith(userName: "");
    }
    _validate();
  }

  setPassword(String password) {
    _passwordStreamController.sink.add(password);
    if (_isPassword(password)) {
      registerObj = registerObj.copyWith(password: password.trim());
    } else {
      registerObj = registerObj.copyWith(password: "");
    }
    _validate();
  }

  setConfirmPassword(String confirm) {
    _confirmPasswordStreamController.sink.add(confirm);
    if (_isConfirmPassword(confirm)) {
      registerObj = registerObj.copyWith(confirmPassword: confirm);
    } else {
      registerObj = registerObj.copyWith(confirmPassword: "");
    }
    _validate();
  }

  //function
  bool _isEmailValid(String email) {
    return isEmail(email);
  }

  bool _isUserName(String userName) {
    return isLength(userName);
  }

  bool _isPassword(String password) {
    return isLength(password);
  }

  bool _isConfirmPassword(String confirmPassword) {
    return confirmPassword == registerObj.password;
  }

  bool _validateAllInput() {
    return registerObj.email.isNotEmpty &&
        registerObj.userName.isNotEmpty &&
        registerObj.password.isNotEmpty &&
        registerObj.confirmPassword.isNotEmpty &&
        registerObj.confirmPassword == registerObj.password;
  }

  _validate() {
    _isAllInputValidStreamController.sink.add(null);
  }

  Future _registerAnAccount() async {
    // add user
    //get photoUrl
    String photoUrl = await FirebaseStorageService().getDefaultImgUrl("users", "avt_default.png");
    PatientUser userData = PatientUser(
      userId: auth.currentUser!.uid,
      email: registerObj.email,
      userName: registerObj.userName,
      photoUrl: photoUrl,
      role: Role.Patient.toString().split('.')[1],
    );
    //insert into db
    await db
        .collection("users")
        .withConverter(
          fromFirestore: PatientUser.fromFirestore,
          toFirestore: (userData, options) => userData.toFirestore(),
        )
        .doc(userData.userId)
        .set(userData);
    UserLoginResponse userLoginResponse = UserLoginResponse(
      email: userData.email,
      userId: userData.userId,
      photoUrl: userData.photoUrl,
      userName: userData.userName,
      role: Role.Patient.toString().split('.')[1],
    );
    UserStore.to.saveProfile(userLoginResponse);
  }

  Future<void> handleSignUp() async {
    AuthResultStatus status = await FirebaseAuthService().createAccount(
      email: registerObj.email,
      password: registerObj.password,
    );
    if (status == AuthResultStatus.successful) {
      await _registerAnAccount();
      Get.toNamed(AppRoutes.VERIFY);
    } else {
      toastInfo(msg: AuthExceptionHandle.generateExceptionMessage(status));
    }
  }

  void handleHaveAlreadyAccount() {
    Get.offNamed(AppRoutes.SIGN_IN);
  }

  //getvalid
  FocusNode get focusNode => _focusNode;
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));
  Stream<bool> get outputIsUserNameValid =>
      _userNameStreamController.stream.map((username) => _isUserName(username));
  Stream<bool> get outputIsPassword =>
      _passwordStreamController.stream.map((password) => _isPassword(password));
  Stream<bool> get outputIsConfirmPassword =>
      _confirmPasswordStreamController.stream
          .map((confirm) => _isConfirmPassword(confirm));
  Stream<bool> get outputIsAllInputValid =>
      _isAllInputValidStreamController.stream
          .map((event) => _validateAllInput());
}
