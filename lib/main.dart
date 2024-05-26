import 'package:booking_doctor/admin/web_main.dart';
import 'package:booking_doctor/users/common/values/colors_value.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/users/common/routes/routes.dart';
import 'package:booking_doctor/users/common/store/config.dart';
import 'package:booking_doctor/users/common/store/user.dart';
import 'package:booking_doctor/firebase_options.dart';
import 'package:booking_doctor/users/common/service/service.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

late SharedPreferences prefWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDateFormatting('vi_Vn', null);
  if (kIsWeb) {
    print("Đang chạy trên web...");
    usePathUrlStrategy();
    prefWeb = await SharedPreferences.getInstance();
    runApp(WebMain());
  } else {
    print("Đang chạy trên ứng dụng");
    await Get.putAsync<StorageService>(() => StorageService().init());
    Get.put<ConfigStore>(ConfigStore());
    Get.put<UserStore>(UserStore());
    await ScreenUtil.ensureScreenSize();
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 720),
      minTextAdapt: true,
      useInheritedMediaQuery: true,
      fontSizeResolver: (fontSize, instance) => fontSize * 1,
      // splitScreenMode: true,
      builder: (_, child) {
        return ToastificationWrapper(
          child: GetMaterialApp(
            useInheritedMediaQuery: true,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoutes.INITIAL,
            getPages: AppPages.routes,
            theme: ThemeData(
              textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
              appBarTheme: const AppBarTheme(
                iconTheme: IconThemeData(color: Colors.white),
              ),
              // iconTheme: const IconThemeData(color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
