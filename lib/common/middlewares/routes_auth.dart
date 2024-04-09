import 'package:flutter/src/widgets/navigator.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/common/routes/routes.dart';
import 'package:booking_doctor/common/store/store.dart';

class RoutesAuth extends GetMiddleware{
  @override
  RouteSettings? redirect(String? route) {
    // if(UserStore.to.isLogin || route == AppRoutes.SIGN_IN || route == AppRoutes.SIGN_UP || )
  }
}