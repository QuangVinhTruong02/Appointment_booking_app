import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:booking_doctor/users/common/entities/hospital.dart';
import 'package:booking_doctor/users/common/routes/routes.dart';
import 'package:booking_doctor/users/common/utils/enum_extension.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:booking_doctor/users/pages/home/home_patient/index.dart';

class HomePatientController extends GetxController {
  HomePatientController();
  HomePatientState state = HomePatientState();
  final db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future _init() async {
    state.isLoading = true;
    await Future.wait([
      _getDoctors(),
      _getHospitals(),
    ]);
    state.isLoading = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _getDoctors() async {
    await db
        .collection("users")
        .where("role", isEqualTo: Role.Doctor.displayRole)
        .withConverter(
          fromFirestore: DoctorUser.fromFirestore,
          toFirestore: (doctorUser, options) => doctorUser.toFirestore(),
        )
        .orderBy("created_at", descending: true)
        .limit(4)
        .get()
        .then((snapshot) async {
      if (snapshot.docs.isNotEmpty && state.isLoadingDoctor) {
        List<DoctorUser> doctors =
            await Future.wait(snapshot.docs.map((e) async {
          DoctorUser doctorUser = e.data();
          Map<String, dynamic> hospitalInfo =
              await _getInfoHospital(e.data().hospitalId!);
          doctorUser.hospitalName = hospitalInfo['hospital_name'];
          doctorUser.hospitalAddress = hospitalInfo['hospital_address'];
          return doctorUser;
        }));
        state.doctors.addAll(doctors);
        state.isLoadingDoctor = false;
      }
    });
    ;
  }

  Future<Map<String, dynamic>> _getInfoHospital(String hospitalId) async {
    return await db
        .collection("hospitals")
        .doc(hospitalId)
        .get()
        .then((value) => value.data()!);
  }

  Future _getHospitals() async {
    await db
        .collection("hospitals")
        .withConverter(
          fromFirestore: Hospital.fromFirestore,
          toFirestore: (hospital, options) => hospital.toFirestore(),
        )
        .orderBy('created_at', descending: true)
        .limit(4)
        .get()
        .then((snapshot) async {
      if (snapshot.docs.isNotEmpty && state.isLoadingHospital) {
        List<Hospital> hospitals = snapshot.docs.map((e) => e.data()).toList();
        state.hospitals.addAll(hospitals);
        state.isLoadingHospital = false;
      }
    });
    ;
  }

  void navigateToDoctorsDirectory() {
    Get.toNamed(AppRoutes.DOCTORS_DIRECTORY);
  }

  void navigateDoctorDetail(String doctorId) {
    Get.toNamed(
      AppRoutes.DOCTOR_DETAIL,
      parameters: {
        'doctor_id': doctorId,
      },
    );
  }
}
