import 'package:booking_doctor/admin/common/services/reload_page.dart';
import 'package:booking_doctor/admin/common/services/storage.dart';
import 'package:booking_doctor/admin/common/store/user.dart';
import 'package:booking_doctor/admin/pages/doctor/doctor_controller.dart';
import 'package:booking_doctor/admin/pages/hospital/hospital_controller.dart';
import 'package:booking_doctor/admin/pages/layout_template/layout_template_controller.dart';
import 'package:booking_doctor/admin/pages/sign_in/controller.dart';
import 'package:booking_doctor/admin/pages/slide_bar/slide_bar_controller.dart';
import 'package:booking_doctor/admin/web_module.dart';
import 'package:booking_doctor/admin/web_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

class WebMain extends StatelessWidget {
  const WebMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StorageServiceWeb>(
          create: (context) => StorageServiceWeb(),
        ),
        ChangeNotifierProvider(
          create: (context) => RouteStorage(
            storageServiceWeb:
                Provider.of<StorageServiceWeb>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => SignInWebController(),
        ),
        ChangeNotifierProvider(
          create: (context) => SlideBarController(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserConfigWeb(
              storageServiceWeb:
                  Provider.of<StorageServiceWeb>(context, listen: false)),
        ),
        ChangeNotifierProvider(
          create: (context) => LayoutTemplateController(
            slideBarController:
                Provider.of<SlideBarController>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => DoctorWebController(),
        ),
        ChangeNotifierProvider(
          create: (context) => HospitalController(),
        ),
      ],
      child: ModularApp(
        module: WebModule(),
        child: WebWidget(),
      ),
    );
  }
}
