// import 'package:booking_doctor/admin/common/routes/route_name.dart';
// import 'package:booking_doctor/admin/pages/doctor/doctor_view.dart';
// import 'package:booking_doctor/admin/pages/hospital/hospital_controller.dart';
// import 'package:booking_doctor/admin/pages/hospital/hospital_view.dart';
// import 'package:booking_doctor/admin/pages/overview/over_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// Route<dynamic> generateRoute(RouteSettings settings) {
//   // var routingData = settings.name!.getRoutingData;
//   switch (settings.name) {
//     case WebRoute.OVER_VIEW:
//       // Get.put<SlideBarController>(SlideBarController());
//       return _getPageRoute(OverView(), settings);
//     case WebRoute.HOPITALS:
//       Get.lazyPut<HostpitalController>(() => HostpitalController());
//       return _getPageRoute(HospitalView(), settings);
//     case WebRoute.DOCTORS:
//       // Get.lazyPut<SlideBarController>(() => SlideBarController());
//       return _getPageRoute(DoctorView(), settings);
//     default:
//       // Get.put<SlideBarController>(SlideBarController());
//       return _getPageRoute(OverView(), settings);
//   }
// }

// PageRoute _getPageRoute(Widget child, RouteSettings settings) {
//   return PageRouteBuilder(
//     settings: settings,
//     pageBuilder: (context, animation, secondaryAnimation) => child,
//     transitionsBuilder: (
//       BuildContext context,
//       Animation<double> animation,
//       Animation<double> secondaryAnimation,
//       Widget child,
//     ) =>
//         FadeTransition(
//       opacity: animation,
//       child: child,
//     ),
//   );
// }
