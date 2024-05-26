import 'package:booking_doctor/users/common/entities/appointment.dart';
import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:booking_doctor/users/common/entities/health_record.dart';
import 'package:booking_doctor/users/common/store/store.dart';
import 'package:booking_doctor/users/common/utils/utils.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:booking_doctor/users/pages/confirm_appointment/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

class ConfirmAppointmentController extends GetxController {
  final db = FirebaseFirestore.instance;
  String healthRecordId = "";
  String previousAppointmentId = "";

  final state = ConfirmAppointmentState();
  List<TimeSlots> calendars = [];

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    state.symptomTextController.dispose();
  }

  _init() {
    state.doctor = Get.arguments['doctor'];
    state.selectedDate = Get.arguments['selected_date'];
    state.selectedTime = Get.arguments['selected_time'];
    state.timeSlotId = Get.arguments['time_slot_id'];
    state.doctorScheduleId = Get.arguments['doctor_schedule_id'];
    if (Get.arguments['health_record_id'] != null) {
      healthRecordId = Get.arguments['health_record_id'];
      previousAppointmentId = Get.arguments['appointment_id'];
      initHealRecord();
    }
  }

  //TODO: Handle submit

  Future<void> handleSubmit(BuildContext context) async {
    if (state.symptomTextController.text.isEmpty) {
      toast(
          toastificationType: ToastificationType.error,
          message: "Vui lòng nhập triệu chứng");
      return;
    }
    if (state.healthRecord == null) {
      toast(
          toastificationType: ToastificationType.error,
          message: "Vui lòng chọn sổ khám bệnh");
      return;
    }
    showLoadingDialog(context);

    await db
        .collection("doctor_schedules")
        .doc(state.doctorScheduleId)
        .collection("time_slots")
        .doc(state.timeSlotId)
        .withConverter(
            fromFirestore: TimeSlots.fromFirestore,
            toFirestore: (value, options) => value.toFirestore())
        .get()
        .then((documentSnapshot) {
      TimeSlots timeSlot = documentSnapshot.data()!;
      //Duyệt qua để kiểm tra xem khung giờ đã tồn tại chưa
      for (int i = 0; i < timeSlot.bookingCounts!.length; i++) {
        if (timeSlot.bookingCounts![i].date == formatDate(state.selectedDate)) {
          if (timeSlot.bookingCounts![i].limit! >= 5) {
            toast(
              toastificationType: ToastificationType.error,
              message:
                  "Khung giờ hiện tại đã đầy, vui lòng chọn khung giờ khác",
            );
            Get.back();
            return;
          } else {
            incrementLimit(documentSnapshot.reference, timeSlot.bookingCounts!);
            createAppointment(context);
            return;
          }
        }
      }
      //Nếu khung giờ chưa tồn tại thì tạo mới
      newBookingCount(timeSlot.bookingCounts!);
      createAppointment(context);
    });
  }

  Future createAppointment(BuildContext context) async {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    DateTime dateTime =
        convertToDateTime(state.selectedDate, state.selectedTime);
    Appointment appointment = Appointment(
      appointmentId: id,
      price: 100000,
      timeSlotId: state.timeSlotId,
      appointmentTime: Timestamp.fromDate(dateTime),
      doctorId: state.doctor.userId,
      patientId: state.healthRecord!.patientId,
      symptoms: state.symptomTextController.text.trim(),
      appointmentStatus: AppointmentStatus.Waiting.name,
      hospitalId: state.doctor.hospitalId,
      major: state.doctor.major,
      healthRecordId: state.healthRecord!.healthRecordId,
    );
    await db
        .collection("appointments")
        .withConverter(
          fromFirestore: Appointment.fromFirestore,
          toFirestore: (appointment, options) => appointment.toFirestore(),
        )
        .doc(appointment.appointmentId)
        .set(appointment);
    if (previousAppointmentId.isNotEmpty) {
      await handleChangeAppointmentStatus(previousAppointmentId);
    }
    toast(
        toastificationType: ToastificationType.success,
        message: "Đặt lịch khám thành công");
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future handleChangeAppointmentStatus(String id) async {
    print("my id: $id");
    await db.collection("appointments").doc(id).update({
      "appointment_status": AppointmentStatus.Completed.name,
    });
  }

  DateTime convertToDateTime(DateTime time, String timeString) {
    // Sử dụng DateFormat để chuyển đổi chuỗi ngày thành DateTime

    // Tạo ra DateTime từ ngày và thời gian
    List<String> timeParts = timeString.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);
    DateTime dateTime = DateTime(time.year, time.month, time.day, hour, minute);

    return dateTime;
  }

  Future newBookingCount(List<BookingCount> bookingCountList) async {
    List<BookingCount> bookingCounts = bookingCountList;
    bookingCounts.add(BookingCount(
      date: formatDate(state.selectedDate),
      limit: 1,
    ));
    await db
        .collection("doctor_schedules")
        .doc(state.doctorScheduleId)
        .collection("time_slots")
        .doc(state.timeSlotId)
        .update({
      "booking_counts": bookingCounts.map((e) => e.toJson()).toList(),
    });
  }

  Future incrementLimit(
      DocumentReference reference, List<BookingCount> bookingCountList) async {
    List<BookingCount> bookingCounts = bookingCountList;
    int index = bookingCounts.indexWhere(
        (element) => element.date == formatDate(state.selectedDate));
    bookingCounts[index].limit = bookingCounts[index].limit! + 1;
    await db
        .collection("doctor_schedules")
        .doc(state.doctorScheduleId)
        .collection("time_slots")
        .doc(state.timeSlotId)
        .update({
      "booking_counts": bookingCounts.map((e) => e.toJson()).toList(),
    });
  }

  Future getHealthRecord() async {
    state.isLoadingHealthRecord = true;
    await db
        .collection("health_records")
        .withConverter(
          fromFirestore: HealthRecord.fromFirestore,
          toFirestore: (value, options) => value.toFiresotre(),
        )
        .where("patient_id", isEqualTo: UserStore.to.token)
        .orderBy("created_at", descending: true)
        .get()
        .then((snapshot) {
      state.healthRecords = snapshot.docs.map((e) => e.data()).toList();
      state.isLoadingHealthRecord = false;
    });
  }

  void onTapSeletectedHealthRecord(HealthRecord healthRecord) {
    state.healthRecord = healthRecord;
    Get.back();
  }

  Future initHealRecord() async {
    await db
        .collection("health_records")
        .doc(healthRecordId)
        .withConverter(
            fromFirestore: HealthRecord.fromFirestore,
            toFirestore: (value, options) => value.toFiresotre())
        .get()
        .then((value) {
      state.healthRecord = value.data();
    });
  }
}
