import 'package:booking_doctor/admin/common/routes/route_name.dart';
import 'package:booking_doctor/admin/common/store/user.dart';
import 'package:booking_doctor/admin/pages/sign_in/index.dart';
import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:booking_doctor/users/common/service/firebase_auth.dart';
import 'package:booking_doctor/users/common/utils/auth_exception.dart';
import 'package:booking_doctor/users/common/utils/enum_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

class SignInWebController extends ChangeNotifier {
  final state = SignInState();
  final db = FirebaseFirestore.instance;

  void bindTextController() {
    state.emailTextEditingController.addListener(() {
      isValidInput();
    });
    state.passwordTextEditingController.addListener(() {
      isValidInput();
    });
  }

  @override
  void dispose() {
    state.emailTextEditingController.dispose();
    state.passwordTextEditingController.dispose();
    super.dispose();
  }

  // @override
  // void onInit() {
  //   // super.onInit();
  // state.emailTextEditingController.addListener(() {
  //   isValidInput();
  // });
  // state.passwordTextEditingController.addListener(() {
  //   isValidInput();
  // });
  // }

  // @override
  // void dispose() {
  //   state.emailTextEditingController.dispose();
  //   state.passwordTextEditingController.dispose();

  //   super.dispose();

  // }

  Future signIn(BuildContext context) async {
    await db
        .collection("users")
        .where("email", isEqualTo: state.emailTextEditingController.text.trim())
        .get()
        .then(
      (querySnapshot) async {
        if (querySnapshot.docs.isNotEmpty) {
          if (querySnapshot.docs.first.data()['role'] ==
              Role.Admin.displayRole) {
            AuthResultStatus status =
                await FirebaseAuthService().loginWithEmailPassword(
              email: state.emailTextEditingController.text.trim(),
              password: state.passwordTextEditingController.text.trim(),
            );
            if (status == AuthResultStatus.successful) {
              state.errorMess = "";
              String email = querySnapshot.docs.first.data()['email'];
              String photoUrl = querySnapshot.docs.first.data()['photo_url'];
              String role = querySnapshot.docs.first.data()['role'];
              String userId = querySnapshot.docs.first.data()['user_id'];
              String userName = querySnapshot.docs.first.data()['user_name'];
              UserLoginResponse user = UserLoginResponse(
                userId: userId,
                userName: userName,
                email: email,
                photoUrl: photoUrl,
                role: role,
              );
              Provider.of<UserConfigWeb>(context, listen: false)
                  .userLoginResponse = user;

              // Get.put<UserConfigWeb>(UserConfigWeb());
              // Get.put<SlideBarController>(SlideBarController());
              // UserConfigWeb.to.initUser(userData);
              Modular.to.navigate(RouteName.OVER_VIEW);
              // Get.offAllNamed(WebRoute.OVER_VIEW);
              // RouteStorage.to.setCurrentRoot(WebRoute.root);
            } else {
              state.errorMess = "Tài khoản hoặc mật khẩu không chính xác";
            }
          } else {
            state.errorMess =
                "Tài khoản này không có quyền truy cập vào trang admin";
          }
        } else {
          state.errorMess = "Tài khoản này không tồn tại";
        }
        notifyListeners();
      },
    );
  }

  // void navigate() {
  //   Modular.to.navigate(RouteName.OVER_VIEW);
  // }

  void isValidInput() {
    if (state.emailTextEditingController.text.isNotEmpty &&
        state.passwordTextEditingController.text.isNotEmpty) {
      state.isValidInput = true;
    } else {
      state.isValidInput = false;
    }
    notifyListeners();
  }
}
