import 'dart:async';
import 'dart:convert';

import 'package:booking_doctor/admin/common/routes/route_name.dart';
import 'package:booking_doctor/admin/common/services/storage.dart';
import 'package:booking_doctor/admin/common/values/storage.dart';
import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UserConfigWeb extends ChangeNotifier {
  StorageServiceWeb storageServiceWeb;
  UserConfigWeb({required this.storageServiceWeb});

  Future<UserLoginResponse?> getUser() async {
    var profile = storageServiceWeb.getString(STORAGE_CURRENT_USER);
    _userLoginResponse = UserLoginResponse.fromJson(
      jsonDecode(profile),
    );
    return _userLoginResponse;
  }

  late UserLoginResponse _userLoginResponse;
  set userLoginResponse(UserLoginResponse user) {
    _userLoginResponse = user;
    storageServiceWeb.setString(
      STORAGE_CURRENT_USER,
      jsonEncode(user.toJson()),
    );
    notifyListeners();
  }

  void remove() {
    storageServiceWeb.remove(STORAGE_CURRENT_USER);
  }

  Future logOut() async {
    final userCredential = await FirebaseAuth.instance.currentUser;
    if (userCredential != null) {
      await FirebaseAuth.instance.signOut();
    }
    remove();
    Modular.to.pushReplacementNamed(RouteName.LOGIN);
  }

  void navigateTo(String routePath) {
    Modular.to.navigate(routePath);
  }

  UserLoginResponse get userLoginResponse => _userLoginResponse;
}
