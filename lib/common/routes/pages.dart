import 'package:booking_doctor/pages/photo_library/index.dart';
import 'package:booking_doctor/pages/edit_profile/doctor/index.dart';
import 'package:booking_doctor/pages/edit_profile/patient/index.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/common/routes/names.dart';
import 'package:booking_doctor/pages/sign_up/index.dart';
import 'package:booking_doctor/pages/sign_up/verify/index.dart';
import 'package:booking_doctor/pages/forgot_password/index.dart';
import 'package:booking_doctor/pages/sign_in/index.dart';
import 'package:booking_doctor/pages/splash/index.dart';
import 'package:booking_doctor/pages/home/index.dart';
import 'package:booking_doctor/pages/create_question/index.dart';
import 'package:booking_doctor/pages/photo_view/index.dart';
import 'package:booking_doctor/pages/detail_question/index.dart';

import 'package:booking_doctor/pages/application/index.dart';

class AppPages {
  static final List<GetPage> routes = [
    // GetPage(
    //   name: AppRoutes.WELCOME,
    //   page: () => WelcomPage(),
    //   binding: WelcomeBinding(),
    //   middlewares: [RoutesWelcomeMiddleware(priority: 1)],
    //   transitionDuration: Duration(microseconds: 500),
    //   transition: Transition.leftToRight,
    // ),
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => const SplashPage(),
      // middlewares: [
      //   RoutesSplashMiddleware(priority: 1),
      // ],
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SIGN_UP,
      page: () => const SignUpPage(),
      binding: SignUpBinding(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.VERIFY,
      page: () => const VerifyPage(),
      binding: VerifyBindings(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.SIGN_IN,
      page: () => const SignInPage(),
      binding: SignInBinding(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.FORGOT_PASSWORD,
      page: () => const ForgotPasswordPage(),
      binding: ForgotPasswordBinding(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.APPLICATION,
      page: () => ApplicationPage(),
      binding: ApplicationBindings(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),
    // GetPage(
    //   name: AppRoutes.CREATE_POST,
    //   page: () => CreatePostPage(),
    //   binding: CreatePostBinding(),
    //   transitionDuration: Duration(milliseconds: 500),
    //   transition: Transition.rightToLeft,
    // ),
    GetPage(
      name: AppRoutes.PHOTO_LIBRARY,
      page: () => const PhotoLibraryPage(),
      binding: PhotoLibraryBinding(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.PHOTO_VIEW,
      page: () => const PhotoViewPage(),
      binding: PhotoViewBinding(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => const HomePage(),
      binding: HomeBindings(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.CREATE_QUESTION,
      page: () => const CreateQuestionPage(),
      binding: CreateQuestionBindings(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.DETAIL_QUESTION,
      page: () => const DetailQuestionPage(),
      binding: DetailQuestionBinding(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),

    GetPage(
      name: AppRoutes.EDIT_PROFILE_PATIENT,
      page: () => const EditProfilePatientPage(),
      binding: EditProfilePatientBinding(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.EDIT_PROFILE_DOCTOR,
      page: () => const EditProfileDoctorPage(),
      binding: EditProfileDoctorBinding(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),

    // GetPage(
    //   name: AppRoutes.SHOW_PDF,
    //   page: () => ShowPdfPage(),
    //   binding: ShowPdfBinding(),
    //   transitionDuration: Duration(milliseconds: 500),
    //   transition: Transition.rightToLeft,
    // ),
  ];
}
