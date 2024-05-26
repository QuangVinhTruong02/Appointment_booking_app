import 'package:booking_doctor/admin/common/routes/route_name.dart';
import 'package:booking_doctor/admin/pages/doctor/doctor_view.dart';
import 'package:booking_doctor/admin/pages/hospital/hospital_view.dart';
import 'package:booking_doctor/admin/pages/layout_template/layout_template.dart';
import 'package:booking_doctor/admin/pages/overview/over_view.dart';
import 'package:booking_doctor/admin/pages/sign_in/index.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WebModule extends Module {
  @override
  // TODO: implement routes
  List<ModularRoute> get routes => [
        ChildRoute(
          RouteName.LOGIN,
          child: (context, args) => SignInWeb(),
          guards: [
            // AuthGuard(),
          ],
        ),
        ChildRoute(
          RouteName.root,
          child: (context, args) => LayoutTemplate(),
          transition: TransitionType.fadeIn,
          children: [
            ChildRoute(
              RouteName.OVER_VIEW,
              child: (context, args) => OverView(),
              transition: TransitionType.fadeIn,
            ),
            ChildRoute(
              RouteName.HOPITALS,
              child: (context, args) => HospitalView(),
              transition: TransitionType.fadeIn,
            ),
            ChildRoute(
              RouteName.DOCTORS,
              child: (context, args) => DoctorWebView(),
              transition: TransitionType.fadeIn,
            ),
          ],
        ),
      ];
}
