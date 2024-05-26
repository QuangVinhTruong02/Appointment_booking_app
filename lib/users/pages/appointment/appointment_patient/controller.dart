import 'package:booking_doctor/users/common/entities/appointment.dart';
import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:booking_doctor/users/common/routes/names.dart';
import 'package:booking_doctor/users/common/store/store.dart';
import 'package:booking_doctor/users/common/utils/utils.dart';
import 'package:booking_doctor/users/common/values/asset_value.dart';
import 'package:booking_doctor/users/common/widgets/show_dialog.dart';
import 'package:booking_doctor/users/common/widgets/toast.dart';
import 'package:booking_doctor/users/pages/appointment/appointment_patient/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:toastification/toastification.dart';

class AppointmentPatientController extends GetxController {
  final state = AppointmentPatientState();
  final db = FirebaseFirestore.instance;
  @override
  void onInit() {
    super.onInit();
    getAppointments();
  }

  Future getAppointments() async {
    state.isLoading = true;
    await db
        .collection("appointments")
        .where("patient_id", isEqualTo: UserStore.to.token)
        .orderBy("created_at", descending: true)
        .withConverter(
          fromFirestore: Appointment.fromFirestore,
          toFirestore: (appointment, options) => appointment.toFirestore(),
        )
        .get()
        .then(
      (snapshot) async {
        List<Appointment> appointments =
            await Future.wait(snapshot.docs.map((e) async {
          Appointment appointment = e.data();
          Map<String, dynamic> infoHospital =
              await _getInfoHospital(appointment.hospitalId!);
          appointment.hospitalName = infoHospital['hospital_name'];
          appointment.hospitalAddress = infoHospital['hospital_address'];
          Map<String, dynamic> infoHealthRecord =
              await _getInfoHealthRecord(appointment.healthRecordId!);
          appointment.patientName = infoHealthRecord['user_name'];
          return appointment;
        }).toList());
        DateTime now = DateTime.now();
        DateFormat dateFormat = DateFormat("dd/MM/yyyy");
        DateFormat timeFormat = DateFormat("HH:mm");
        Future.wait(
          appointments.map(
            (e) async {
              DateTime date1 = dateFormat.parse(formatDate(DateTime.now()));
              DateTime date2 =
                  dateFormat.parse(formatDate(e.appointmentTime!.toDate()));
              DateTime time1 = timeFormat.parse(
                timeFormat.format(
                  DateTime(now.year, now.month, now.day, 16, 30, 0),
                ),
              );
              DateTime time2 = timeFormat.parse(timeFormat.format(now));
              if (date1.isAfter(date2) &&
                  e.appointmentStatus == AppointmentStatus.Waiting.name) {
                handleChangeCancelOutDate(snapshot, e);
              }
              if (isSameDay(date1, date2) &&
                  time2.isAfter(time1) &&
                  e.appointmentStatus == AppointmentStatus.Waiting.name) {
                handleChangeCancelOutDate(snapshot, e);
                e.appointmentStatus = AppointmentStatus.Canceled.name;
              }
            },
          ),
        );
        _listBinds(appointments);
        state.isLoading = false;
      },
    );
  }

  void _listBinds(List<Appointment> appointments) {
    state.appointmentWaitingList = appointments
        .where((e) => e.appointmentStatus == AppointmentStatus.Waiting.name)
        .cast<Appointment>()
        .toList();
    state.appointmentCompletedList = appointments
        .where((e) => e.appointmentStatus == AppointmentStatus.Completed.name)
        .cast<Appointment>()
        .toList();
    state.appointmentCancelList = appointments
        .where((e) => e.appointmentStatus == AppointmentStatus.Canceled.name)
        .cast<Appointment>()
        .toList();
  }

  Future handleChangeCancelOutDate(
      QuerySnapshot<Appointment> snapshot, Appointment appointment) async {
    await snapshot.docs
        .where((element) =>
            element.data().appointmentId == appointment.appointmentId)
        .first
        .reference
        .update({
      "appointment_status": AppointmentStatus.Canceled.name,
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

  void handleCancelAppointment(Appointment appointment, BuildContext context) {
    showQuestionDialog(
      context: context,
      title: "Xác nhận huỷ lịch hẹn",
      lottieAsset: AssetJsonValue.warning,
      onTapSubmit: () async {
        showLoadingDialog(context);
        await _cancelAppointment(appointment);
        Get.back();
        state.tabController.animateTo(2);
      },
      onTapCancel: () {
        Get.back();
      },
    );
  }
  //TODO: implement _cancelAppointment

  Future _cancelAppointment(Appointment appointment) async {
    await db.collection("appointments").doc(appointment.appointmentId).update({
      "appointment_status": AppointmentStatus.Canceled.name,
    });
    await db
        .collection("doctor_schedules")
        .where("doctor_id", isEqualTo: appointment.doctorId)
        .withConverter(
          fromFirestore: DoctorSchedule.fromFirestore,
          toFirestore: (workSchedule, options) => workSchedule.toFirestore(),
        )
        .get()
        .then((querySnapshot) async {
      await querySnapshot.docs.first.reference
          .collection("time_slots")
          .doc(appointment.timeSlotId)
          .withConverter(
            fromFirestore: TimeSlots.fromFirestore,
            toFirestore: (value, options) => value.toFirestore(),
          )
          .get()
          .then(
        (querySnapshot) {
          TimeSlots timeSlots = querySnapshot.data()!;
          int indexBookingCount = timeSlots.bookingCounts!.indexWhere(
            (element) =>
                element.date ==
                formatDate(
                  appointment.appointmentTime!.toDate(),
                ),
          );
          timeSlots.bookingCounts![indexBookingCount].limit =
              timeSlots.bookingCounts![indexBookingCount].limit! - 1;
          querySnapshot.reference.update({
            "booking_counts": timeSlots.bookingCounts,
          });
          toast(
              toastificationType: ToastificationType.success,
              message: "Huỷ đặt lịch thành công");
        },
      ).whenComplete(() {
        state.appointmentWaitingList.remove(appointment);
        appointment.appointmentStatus = AppointmentStatus.Canceled.name;
        state.appointmentCancelList.insert(0, appointment);
      });
    });
  }

  void navigateToAppointmentDetail(String appointmentId) {
    Get.toNamed(
      AppRoutes.APPOINTMENT_DETAIL,
      arguments: {
        "appointment_id": appointmentId,
      },
    );
  }
}
