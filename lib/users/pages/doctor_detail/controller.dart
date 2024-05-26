import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:booking_doctor/users/common/routes/names.dart';
import 'package:booking_doctor/users/pages/doctor_detail/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorDetailController extends GetxController {
  DoctorDetailController();
  final state = DoctorDetailState();
  final db = FirebaseFirestore.instance;
  String doctorId = "";

  @override
  void onInit() {
    super.onInit();
    doctorId = Get.parameters['doctor_id']!;
    _getDoctorUserById();
  }

  Future _getDoctorUserById() async {
    await db
        .collection("users")
        .where("user_id", isEqualTo: doctorId)
        .withConverter(
          fromFirestore: DoctorUser.fromFirestore,
          toFirestore: (doctorUser, options) => doctorUser.toFirestore(),
        )
        .get()
        .then(
      (querySnapshot) async {
        state.doctor = querySnapshot.docs.first.data();
        Map<String, dynamic> hospitalInfo =
            await _getInfoHospital(querySnapshot.docs.first.data().hospitalId!);
        state.doctor.hospitalName = hospitalInfo['hospital_name'];
        state.doctor.hospitalAddress = hospitalInfo['hospital_address'];
        state.doctor.workProgress!
            .map((e) => state.descriptionWorkProgress +=
                "- ${e.yearOfWork}: ${e.workAt} \n")
            .toList();

        state.isLoading = false;
      },
    );
  }

  Future<Map<String, dynamic>> _getInfoHospital(String hospitalId) async {
    return await db
        .collection("hospitals")
        .doc(hospitalId)
        .get()
        .then((value) => value.data()!);
  }

  void navigateToAppointmentDateTime(BuildContext context) {
    Get.toNamed(
      AppRoutes.APPOINTMENT_CALENDAR,
      arguments: {
        'doctor': state.doctor,
      },
    );
  }
}
