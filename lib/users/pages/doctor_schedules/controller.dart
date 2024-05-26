import 'package:booking_doctor/users/common/entities/doctor_schedule.dart';
import 'package:booking_doctor/users/common/store/store.dart';
import 'package:booking_doctor/users/common/utils/date.dart';
import 'package:booking_doctor/users/common/values/values.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:booking_doctor/users/pages/doctor_schedules/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:uuid/uuid.dart';

class DoctorScheduleController extends GetxController {
  final db = FirebaseFirestore.instance;
  DoctorScheduleController();
  final state = DoctorScheduleState();

  @override
  void onInit() {
    super.onInit();
    initWorkingTime();
    initWorkingDay();
    getDoctorWorkSchedule();
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    state.toDay = selectedDay;
    print(state.toDay);
  }

  void initWorkingTime() {
    state.listWorkingTime.add(CheckBoxObject(name: "08:00", value: false));
    state.listWorkingTime.add(CheckBoxObject(name: "09:00", value: false));
    state.listWorkingTime.add(CheckBoxObject(name: "10:00", value: false));
    state.listWorkingTime.add(CheckBoxObject(name: "11:00", value: false));
    state.listWorkingTime.add(CheckBoxObject(name: "13:00", value: false));
    state.listWorkingTime.add(CheckBoxObject(name: "14:00", value: false));
    state.listWorkingTime.add(CheckBoxObject(name: "15:00", value: false));
    state.listWorkingTime.add(CheckBoxObject(name: "16:00", value: false));
  }

  void initWorkingDay() {
    for (int i = 0; i < 7; i++) {
      state.listWorkingDay.add(
        CheckBoxObject(
          name: i == 6 ? "Chủ nhật" : "Thứ ${i + 2}",
          value: false,
        ),
      );
    }
  }

  Future getDoctorWorkSchedule() async {
    state.isLoading = true;
    await db
        .collection('doctor_schedules')
        .withConverter(
          fromFirestore: DoctorSchedule.fromFirestore,
          toFirestore: (value, options) => value.toFirestore(),
        )
        .where('doctor_id', isEqualTo: UserStore.to.token)
        .get()
        .then(
      (value) {
        if (value.docs.isNotEmpty) {
          state.doctorSchedule = value.docs.first.data();
        }
        value.docs.first.reference
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
              state.isLoading = false;
            }
          },
        );
      },
    );
  }

  void onChangeWorkingDay(bool value, int index) {
    state.listWorkingDay[index] = CheckBoxObject(
      name: state.listWorkingDay[index].name,
      value: value,
    );
  }

  void onChangeWorkingTime(bool value, int index) {
    state.listWorkingTime[index] = CheckBoxObject(
      name: state.listWorkingTime[index].name,
      value: value,
    );
  }

  void handleSaveChange(BuildContext context) {
    bool isWorkingEmpty =
        state.listWorkingDay.any((element) => element.value == true);
    if (!isWorkingEmpty) {
      toast(
          toastificationType: ToastificationType.error,
          message: "Vui lòng chọn ngày làm việc");
      return;
    }
    isWorkingEmpty =
        state.listWorkingTime.any((element) => element.value == true);
    if (!isWorkingEmpty) {
      toast(
          toastificationType: ToastificationType.error,
          message: "Vui lòng chọn giờ làm việc");
      return;
    }
    showQuestionDialog(
      context: context,
      title: "Xác nhận lưu thay đổi",
      lottieAsset: AssetJsonValue.warning,
      onTapSubmit: () {
        saveChange().whenComplete(() {
          toast(
            toastificationType: ToastificationType.success,
            message: "Lưu thay đổi thành công",
          );
          Get.back();
          state.listWorkingDay.clear();
          state.listWorkingTime.clear();
        });
      },
      onTapCancel: () {
        Get.back();
        state.listWorkingDay.clear();
        state.listWorkingTime.clear();
      },
    );
  }

  Future saveChange() async {
    Uuid uuid = Uuid();
    String id = uuid.v1();
    DoctorSchedule doctorSchedule = DoctorSchedule(
      doctorScheduleId: id,
      doctorId: UserStore.to.token,
      daysOfWeek: state.listWorkingDay
          .where((element) => element.value == true)
          .map((e) => e.name)
          .toList(),
    );
    await db
        .collection('doctor_schedules')
        .withConverter(
          fromFirestore: DoctorSchedule.fromFirestore,
          toFirestore: (value, options) => value.toFirestore(),
        )
        .doc(id)
        .set(doctorSchedule)
        .whenComplete(
      () async {
        state.listWorkingTime.sort((a, b) {
          int timeA = int.parse(a.name.split(":")[0]);
          int timeB = int.parse(b.name.split(":")[0]);
          return timeA.compareTo(timeB);
        });
        state.listWorkingTime.where((element) => element.value == true).forEach(
          (element) async {
            TimeSlots timeSlots = TimeSlots(
              timeSlotId: uuid.v1(),
              time: element.name,
              bookingCounts: [],
            );
            await saveTimeSlot(timeSlots, id);
          },
        );
      },
    );
  }

  Future saveTimeSlot(TimeSlots timeSlots, String doctorWorkScheduleId) async {
    await db
        .collection('doctor_schedules')
        .doc(doctorWorkScheduleId)
        .collection('time_slots')
        .withConverter(
          fromFirestore: TimeSlots.fromFirestore,
          toFirestore: (value, options) => value.toFirestore(),
        )
        .doc(timeSlots.timeSlotId)
        .set(timeSlots);
  }

  bool isAvailableDay(DateTime date) {
    String day = formatDay(date);
    if (state.doctorSchedule.daysOfWeek!.contains(day)) {
      return true;
    }
    return false;
  }
}
