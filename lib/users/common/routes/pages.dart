import 'package:booking_doctor/users/pages/appointment/appointment_detail/index.dart';
import 'package:booking_doctor/users/pages/confirm_appointment/index.dart';
import 'package:booking_doctor/users/pages/health_record_page/health_record_form/index.dart';
import 'package:booking_doctor/users/pages/health_record_page/health_record_detail/index.dart';

import 'package:booking_doctor/users/pages/photo_library/index.dart';
import 'package:booking_doctor/users/pages/edit_profile/doctor/index.dart';
import 'package:booking_doctor/users/pages/edit_profile/patient/index.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/users/common/routes/names.dart';
import 'package:booking_doctor/users/pages/sign_up/index.dart';
import 'package:booking_doctor/users/pages/sign_up/verify/index.dart';
import 'package:booking_doctor/users/pages/forgot_password/index.dart';
import 'package:booking_doctor/users/pages/sign_in/index.dart';
import 'package:booking_doctor/users/pages/splash/index.dart';
import 'package:booking_doctor/users/pages/home/home_patient/index.dart';
import 'package:booking_doctor/users/pages/home/home_doctor/index.dart';
import 'package:booking_doctor/users/pages/doctor_schedules/index.dart';
import 'package:booking_doctor/users/pages/doctors_directory/index.dart';
import 'package:booking_doctor/users/pages/doctor_detail/index.dart';
import 'package:booking_doctor/users/pages/create_question/index.dart';
import 'package:booking_doctor/users/pages/photo_view/index.dart';
import 'package:booking_doctor/users/pages/detail_question/index.dart';
import 'package:booking_doctor/users/pages/application/index.dart';
import 'package:booking_doctor/users/pages/appointment_calendar/index.dart';
import 'package:booking_doctor/users/pages/appointment_calendar/index.dart';

class AppPages {
  static final List<GetPage> routes = [
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
      name: AppRoutes.HOME_PATIENT,
      page: () => const HomePatientPage(),
      binding: HomePatientBindings(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.HOME_DOCTOR,
      page: () => const HomeDoctorPage(),
      binding: HomeDoctorBindings(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.DOCTOR_SCHEDULE,
      page: () => const DoctorSchedulePage(),
      binding: WorkScheduleBindings(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.DOCTORS_DIRECTORY,
      page: () => const DoctorsDirectoryPage(),
      binding: DoctorsDirectoryBindings(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.HEALTH_RECORD_DETAIL,
      page: () => const HealthRecordDetailPage(),
      binding: HealthRecordDetailBindings(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.HEALTH_RECORD_FORM,
      page: () => const HealthRecordFormPage(),
      binding: HealthRecordFormBindings(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.DOCTOR_DETAIL,
      page: () => const DoctorDetailPage(),
      binding: DoctorDetailBindings(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.APPOINTMENT_CALENDAR,
      page: () => const AppointmentCalendarPage(),
      binding: AppointmentCalendarBindings(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.APPOINTMENT_DETAIL,
      page: () => const AppointmentDetailPage(),
      binding: AppointmentDetailBindings(),
      transitionDuration: const Duration(milliseconds: 500),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.CONFIRM_APPOINTMENT,
      page: () => const ConfirmAppointmentPage(),
      binding: ConfirmAppointmentBindings(),
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
  ];
}
