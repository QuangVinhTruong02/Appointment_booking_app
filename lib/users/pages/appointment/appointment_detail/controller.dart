import 'package:booking_doctor/users/common/entities/appointment.dart';
import 'package:booking_doctor/users/common/entities/doctor.dart';
import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:booking_doctor/users/common/routes/names.dart';
import 'package:booking_doctor/users/common/utils/utils.dart';
import 'package:booking_doctor/users/common/values/values.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:booking_doctor/users/pages/appointment/appointment_detail/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentDetailController extends GetxController {
  AppointmentDetailController();
  final db = FirebaseFirestore.instance;
  final state = AppointmentDetailState();
  String appointmentId = "";

  @override
  void onInit() {
    super.onInit();
    appointmentId = Get.arguments['appointment_id']!;
    getAppointment();
  }

  Future getAppointment() async {
    state.isLoading = true;
    await db
        .collection("appointments")
        .withConverter(
          fromFirestore: Appointment.fromFirestore,
          toFirestore: (value, options) => value.toFirestore(),
        )
        .doc(appointmentId)
        .get()
        .then((snapshot) async {
      state.appointment = snapshot.data();
      Map<String, dynamic> infoHospital =
          await _getInfoHospital(state.appointment!.hospitalId!);
      state.appointment!.hospitalName = infoHospital['hospital_name'];
      state.appointment!.hospitalAddress = infoHospital['hospital_address'];
      Map<String, dynamic> infoHealthRecord =
          await _getInfoHealthRecord(state.appointment!.healthRecordId!);
      state.appointment!.patientName = infoHealthRecord['user_name'];
      state.doctor = await getDoctor(state.appointment!.doctorId!);
      state.isLoading = false;
      print("status: ${state.appointment!.appointmentStatus}");
    });
  }

  Future<Map<String, dynamic>> _getInfoHospital(String hospitalId) async {
    return await db
        .collection("hospitals")
        .doc(hospitalId)
        .get()
        .then((value) => value.data()!);
  }

  Future<Map<String, dynamic>> _getInfoHealthRecord(
      String healthRecordId) async {
    return await db
        .collection("health_records")
        .doc(healthRecordId)
        .get()
        .then((value) => value.data()!);
  }

  Future<DoctorUser> getDoctor(String doctorId) async {
    return await db
        .collection("users")
        .doc(doctorId)
        .withConverter(
          fromFirestore: DoctorUser.fromFirestore,
          toFirestore: (value, options) => value.toFirestore(),
        )
        .get()
        .then((value) => value.data()!);
  }

  Future handleSubmitCompleted(BuildContext context) async {
    showQuestionDialog(
      context: context,
      title: "Xác nhận đã khám",
      lottieAsset: AssetJsonValue.question,
      onTapSubmit: () {
        state.isLoading = true;
        db.collection("appointments").doc(appointmentId).update({
          "appointment_status": AppointmentStatus.Completed.name,
        }).then((value) {
          state.isLoading = false;
          Navigator.of(context).popUntil((route) => route.isFirst);
        });
      },
      onTapCancel: () {
        Get.back();
      },
    );
  }

  Future navigateToAppointmentCalendar() async {
    Map<String, dynamic> getInfoHospital = await db
        .collection("hospitals")
        .doc(state.appointment!.hospitalId)
        .get()
        .then((value) => value.data()!);
    state.doctor.hospitalName = getInfoHospital['hospital_name'];
    state.doctor.hospitalAddress = getInfoHospital['hospital_address'];
    Get.toNamed(AppRoutes.APPOINTMENT_CALENDAR, arguments: {
      'doctor': state.doctor,
      'health_record_id': state.appointment!.healthRecordId!,
      'appointment_id': state.appointment!.appointmentId,
    });
  }
}
