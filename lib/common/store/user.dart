import 'dart:convert';

import 'package:get/get.dart';
import 'package:booking_doctor/common/entities/entities.dart';
import 'package:booking_doctor/common/service/service.dart';
import 'package:booking_doctor/common/values/values.dart';

class UserStore extends GetxController {
  static UserStore get to => Get.find();

  final _isLogin = false.obs;
  String token = '';
  var _userLoginResponse = UserLoginResponse().obs;

  bool get isLogin => _isLogin.value;
  bool get hasToken => token.isNotEmpty;
  UserLoginResponse get userLoginResponse => _userLoginResponse.value;
  // set userLoginResponse(UserLoginResponse userRes) =>
  //     _userLoginResponse.value = userRes;

  @override
  void onInit() {
    super.onInit();
    token = StorageService.to.getString(STORAGE_USER_ID);
    var profileOffline = StorageService.to.getString(STORAGE_USER_PROFILE);
    if (token.isNotEmpty) {
      _isLogin.value = true;
      _userLoginResponse.value = UserLoginResponse.fromJson(
        jsonDecode(profileOffline),
      );
    }
  }

  Future<void> saveToken(String value) async {
    await StorageService.to.setString(STORAGE_USER_ID, value);
    token = value;
  }

  Future<void> saveProfile(UserLoginResponse profile) async {
    _userLoginResponse.value = profile;
    await StorageService.to
        .setString(STORAGE_USER_PROFILE, jsonEncode(profile.toJson()));
    await saveToken(profile.userId ?? "");
  }

  Future<void> onLogout() async {
    await StorageService.to.remove(STORAGE_USER_ID);
    await StorageService.to.remove(STORAGE_USER_PROFILE);
    _isLogin.value = false;
    token = '';
  }
}
