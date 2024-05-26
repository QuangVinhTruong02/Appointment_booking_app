import 'package:booking_doctor/users/common/entities/appointment.dart';
import 'package:booking_doctor/users/common/routes/names.dart';
import 'package:booking_doctor/users/common/store/store.dart';
import 'package:booking_doctor/users/common/utils/utils.dart';
import 'package:booking_doctor/users/pages/appointment/appointment_doctor.dart/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentDoctorController extends GetxController {
  final state = AppointmentDoctorState();
  final db = FirebaseFirestore.instance;
  @override
  void onInit() {
    super.onInit();
    listBinds();
  }

  @override
  void dispose() {
    super.dispose();
    state.refreshUpcomingController.dispose();
  }

  Future<List<Appointment>> getAppointments() async {
    DateTime now = DateTime.now();
    DateTime startTime = DateTime(now.year, now.month, now.day, 0, 0, 0);
    DateTime endTime = DateTime(now.year, now.month, now.day, 23, 59, 59);
    return await db
        .collection("appointments")
        .where("doctor_id", isEqualTo: UserStore.to.token)
        .where('appointment_time',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startTime))
        .where(
          'appointment_time',
          isLessThan: Timestamp.fromDate(endTime),
        )
        .orderBy("appointment_time", descending: false)
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
          state.appointmentUpcomingList.map(
            (e) async {
              DateTime date1 = dateFormat.parse(formatDate(now));
              DateTime date2 =
                  dateFormat.parse(formatDate(e.appointmentTime!.toDate()));
              //TODO: check time
              DateTime time1 = timeFormat.parse(timeFormat
                  .format(DateTime(now.year, now.month, now.day, 23, 30, 0)));
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
        return appointments;
      },
    );
  }

  Future getAllAppointments() async {
    state.appointmentAllList = await getAppointments();
  }

  Future getUpcomingAppointments() async {
    state.appointmentUpcomingList = await getAppointments().then((value) {
      return value
          .where((e) => e.appointmentTime!.toDate().isAfter(DateTime.now()))
          .cast<Appointment>()
          .toList();
    });
  }

  Future listBinds() async {
    state.isLoading = true;
    await Future.wait([
      getUpcomingAppointments(),
      getAllAppointments(),
    ]);
    state.isLoading = false;
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

  Future navigateToAppointmentDetail(String appointmentId) async {
    await Get.toNamed(
      AppRoutes.APPOINTMENT_DETAIL,
      arguments: {
        "appointment_id": appointmentId,
      },
    );
    listBinds();
  }

  Future onAllRefresh() async {
    await listBinds();
    state.refreshAllController.refreshCompleted();
  }

  Future onUpcomingRefresh() async {
    await listBinds();
    state.refreshUpcomingController.refreshCompleted();
  }
}
