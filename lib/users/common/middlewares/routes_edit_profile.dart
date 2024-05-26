import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:booking_doctor/users/common/store/store.dart';
import 'package:booking_doctor/users/common/utils/enum_extension.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';

class RoutesEditProfile extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    if (UserStore.to.userLoginResponse.role ==
        Role.Patient.toString().split('.')[1]) {}
    return super.redirect(route);
  }
}
