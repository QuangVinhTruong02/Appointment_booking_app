// import 'package:booking_doctor/pages/group_question/all_question/index.dart';
import 'package:booking_doctor/users/common/store/store.dart';
import 'package:booking_doctor/users/common/utils/enum_extension.dart';
import 'package:booking_doctor/users/pages/appointment/appointment_doctor.dart/controller.dart';
import 'package:booking_doctor/users/pages/doctor_schedules/controller.dart';
import 'package:booking_doctor/users/pages/group_question/controller.dart';
import 'package:booking_doctor/users/pages/health_record_page/controller.dart';
import 'package:booking_doctor/users/pages/health_record_page/health_record_detail/controller.dart';
import 'package:booking_doctor/users/pages/home/home_doctor/controller.dart';
import 'package:booking_doctor/users/pages/appointment/appointment_patient/index.dart';
// import 'package:booking_doctor/pages/group_question/your_question/index.dart';
import 'package:get/get.dart';
import 'package:booking_doctor/users/pages/application/controller.dart';
import 'package:booking_doctor/users/pages/home/home_patient/index.dart';
import 'package:booking_doctor/users/pages/profile/index.dart';

class ApplicationBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApplicationController>(() => ApplicationController());
    if (UserStore.to.userLoginResponse.role == Role.Doctor.displayRole) {
      Get.lazyPut<HomeDoctorController>(() => HomeDoctorController());
      Get.lazyPut<DoctorScheduleController>(() => DoctorScheduleController());
      Get.lazyPut<AppointmentDoctorController>(
          () => AppointmentDoctorController());
    }
    if (UserStore.to.userLoginResponse.role == Role.Patient.displayRole) {
      Get.lazyPut<HomePatientController>(() => HomePatientController());
      Get.lazyPut<HeathRecordController>(() => HeathRecordController());
      Get.lazyPut<AppointmentPatientController>(
          () => AppointmentPatientController());
    }
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<GroupQuestionController>(() => GroupQuestionController());

    // Get.lazyPut<AllQuestionController>(() => AllQuestionController());
    // Get.lazyPut<YourQuestionController>(() => YourQuestionController());
  }
}
