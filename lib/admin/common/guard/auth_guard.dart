// import 'dart:async';

// import 'package:booking_doctor/admin/common/routes/route_name.dart';
// import 'package:booking_doctor/admin/common/services/auth_service.dart';
// import 'package:flutter_modular/flutter_modular.dart';

// class AuthGuard extends RouteGuard {
//   AuthGuard() : super(redirectTo: RouteName.LOGIN);
//   final AuthService _authService = AuthService();
//   @override
//   FutureOr<bool> canActivate(String path, ParallelRoute route) async {
//     bool isAuthenticated = await _authService.isUserLoggedIn();
//     if (isAuthenticated && path == RouteName.LOGIN) {
//       Modular.to.navigate(RouteName.OVER_VIEW);
//       return false;
//     }
//     return true;
//   }
// }
