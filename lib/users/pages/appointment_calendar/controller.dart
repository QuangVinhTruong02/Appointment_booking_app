import 'dart:async';

import 'package:booking_doctor/users/common/entities/doctor_schedule.dart';
import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:booking_doctor/users/common/routes/names.dart';
import 'package:booking_doctor/users/common/utils/date.dart';
import 'package:booking_doctor/users/common/widgets/toast.dart';
import 'package:booking_doctor/users/pages/appointment_calendar/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

class AppointmentCalendarController extends GetxController {
  final db = FirebaseFirestore.instance;
  final state = AppointmentCalendarState();
  DoctorUser doctor = DoctorUser();
  String healthRecordId = "";

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      doctor = Get.arguments['doctor'] as DoctorUser;
      healthRecordId = Get.arguments['health_record_id'] ?? "";
      getDoctorWorkSchedule();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future getDoctorWorkSchedule() async {
    state.isLoading = true;
    await db
        .collection('doctor_schedules')
        .withConverter(
          fromFirestore: DoctorSchedule.fromFirestore,
          toFirestore: (value, options) => value.toFirestore(),
        )
        .where('doctor_id', isEqualTo: doctor.userId)
        .get()
        .then(
      (querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          state.doctorSchedule = querySnapshot.docs.first.data();
          querySnapshot.docs.first.reference
              .collection('time_slots')
              .withConverter(
                fromFirestore: TimeSlots.fromFirestore,
                toFirestore: (value, options) => value.toFirestore(),
              )
              .get()
              .then(
            (value) {
              if (value.docs.isNotEmpty) {
                state.timeSlots = value.docs.map((e) => e.data()).toList();
                if (state.doctorSchedule.daysOfWeek
                        ?.contains(formatDay(DateTime.now())) ??
                    false) {
                  state.availableTimeSlots = state.timeSlots;
                }
                state.isLoading = false;
              }
              deleteOldDates();
            },
          );
        } else {
          state.isHaveData = false;
          state.isLoading = false;
        }
      },
    );
  }

  bool isAvailableDay(DateTime date) {
    String day = formatDay(date);
    if (state.doctorSchedule.daysOfWeek!.contains(day) &&
        (date.isAfter(DateTime.now()) ||
            formatDate(date) == formatDate(DateTime.now()))) {
      return true;
    }
    return false;
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    state.selectedDate = selectedDay;
    state.availableTimeSlots = state.timeSlots;
    state.selectedTimeSlot = null;
  }

  void onTimeSlotSelected(TimeSlots timeSlot) {
    state.selectedTimeSlot = timeSlot;
  }

  bool isAvailableTimeSlot(TimeSlots timeSlot) {
    if (formatDate(state.selectedDate) == formatDate(DateTime.now())) {
      if (DateFormat('HH:mm')
          .parse(formatTime(DateTime.now()))
          .isAfter(DateFormat('HH:mm').parse(timeSlot.time!))) {
        return false;
      }
    }
    for (int i = 0; i < timeSlot.bookingCounts!.length; i++) {
      if (timeSlot.bookingCounts?[i].date == formatDate(state.selectedDate)) {
        if (timeSlot.bookingCounts![i].limit! >= 5) {
          return false;
        }
      }
    }
    return true;
  }

  Future<void> handleSubmitBooking(BuildContext context) async {
    if (state.selectedTimeSlot == null) {
      toast(
          toastificationType: ToastificationType.error,
          message: "Vui lòng chọn giờ làm việc");
      return;
    }
    Get.toNamed(AppRoutes.CONFIRM_APPOINTMENT, arguments: {
      'doctor': doctor,
      'selected_date': state.selectedDate,
      'selected_time': state.selectedTimeSlot!.time,
      'time_slot_id': state.selectedTimeSlot?.timeSlotId ?? "",
      'doctor_schedule_id': state.doctorSchedule.doctorScheduleId,
      if (healthRecordId.isNotEmpty) 'health_record_id': healthRecordId,
      if (Get.arguments['appointment_id'] != null)
        'appointment_id': Get.arguments['appointment_id']
    });
    print(Get.arguments['appointment_id']);
  }

  Future deleteOldDates() async {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    state.timeSlots.forEach((element) {
      element.bookingCounts?.removeWhere((element) => formatter
          .parse(element.date!)
          .isBefore(formatter.parse(formatDate(DateTime.now()))));
    });
    await db
        .collection("doctor_schedules")
        .doc(state.doctorSchedule.doctorScheduleId)
        .collection("time_slots")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.update({
          "booking_counts": state.timeSlots
              .firstWhere((element1) => element1.timeSlotId == element.id)
              .bookingCounts
              ?.map((e) => e.toJson())
        });
      });
    });
  }
}
