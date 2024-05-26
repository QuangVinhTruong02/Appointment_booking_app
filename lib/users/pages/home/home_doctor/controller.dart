import 'package:booking_doctor/users/common/entities/appointment.dart';
import 'package:booking_doctor/users/common/entities/doctor.dart';
import 'package:booking_doctor/users/common/store/store.dart';
import 'package:booking_doctor/users/common/utils/date.dart';
import 'package:booking_doctor/users/common/utils/enum_extension.dart';
import 'package:booking_doctor/users/pages/home/home_doctor/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeDoctorController extends GetxController {
  HomeDoctorController();
  final state = HomeDoctorState();
  final db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    getAppointment();
    getDoctor();
  }

  Future getAppointment() async {
    state.isAppointmentOverviewLoading = true;
    await db
        .collection("appointments")
        .withConverter(
          fromFirestore: Appointment.fromFirestore,
          toFirestore: (value, options) => value.toFirestore(),
        )
        .where("doctor_id", isEqualTo: UserStore.to.token)
        .get()
        .then((value) {
      state.appointments = value.docs.map((e) => e.data()).toList();
      state.appointments = state.appointments
          .where((element) =>
              formatDate(element.appointmentTime!.toDate()) ==
              formatDate(DateTime.now()))
          .toList();
      state.appointments.forEach((element) {
        if (element.appointmentStatus == AppointmentStatus.Completed.name) {
          state.totalAppointmentsSuccess++;
        } else if (element.appointmentStatus ==
            AppointmentStatus.Waiting.name) {
          state.totalAppointmentsWaiting++;
        } else if (element.appointmentStatus ==
            AppointmentStatus.Canceled.name) {
          state.totalAppointmentsCancel++;
        }
      });
      state.isAppointmentOverviewLoading = false;
    });
  }

  Future getDoctor() async {
    print("123");
    state.isDoctorLoading = true;
    await db
        .collection("users")
        .withConverter(
          fromFirestore: DoctorUser.fromFirestore,
          toFirestore: (value, options) => value.toFirestore(),
        )
        .doc(UserStore.to.token)
        .get()
        .then((value) {
      state.doctor = value.data()!;
      state.isDoctorLoading = false;
      print("Photo Url: ${state.doctor.photoUrl}");
      print("laoding: ${state.isDoctorLoading}");
    });
  }
}
