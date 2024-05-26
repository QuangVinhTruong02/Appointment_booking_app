import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:booking_doctor/users/common/routes/names.dart';
import 'package:booking_doctor/users/common/utils/enum_extension.dart';
import 'package:booking_doctor/users/pages/doctors_directory/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DoctorsDirectoryController extends GetxController {
  final DoctorsDirectoryState state = DoctorsDirectoryState();
  final db = FirebaseFirestore.instance;
  DocumentSnapshot? _lastDocumentDoctor;

  @override
  void onInit() {
    super.onInit();
    _getDoctors();
    state.scrollDoctorController.addListener(_onScroll);
  }

  void onTapCloseButton() {
    _lastDocumentDoctor = null;
    state.searchController.clear();
    state.doctors.clear();
    state.isOnTapSearchText = false;
    state.isLoading = true;
    _getDoctors();
  }

  Future _getDoctors() async {
    var query = await db
        .collection("users")
        .where("role", isEqualTo: Role.Doctor.displayRole)
        .withConverter(
          fromFirestore: DoctorUser.fromFirestore,
          toFirestore: (doctorUser, options) => doctorUser.toFirestore(),
        )
        .orderBy("created_at", descending: true)
        .limit(10);
    if (_lastDocumentDoctor != null) {
      query = query.startAfter([_lastDocumentDoctor!['created_at']]);
    }
    query.get().then((snapshot) async {
      if (snapshot.docs.isNotEmpty && state.isLoading) {
        _lastDocumentDoctor = snapshot.docs[snapshot.docs.length - 1];
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
        state.isLoading = false;
      }
      if (snapshot.docs.isEmpty) {
        state.scrollDoctorController.removeListener(_onScroll);
        state.isLoading = false;
      }
    });
  }

  Future<Map<String, dynamic>> _getInfoHospital(String hospitalId) async {
    return await db
        .collection("hospitals")
        .doc(hospitalId)
        .get()
        .then((value) => value.data()!);
  }

  void _onScroll() {
    if (!state.isLoading) {
      if (state.scrollDoctorController.position.pixels <=
          state.scrollDoctorController.position.maxScrollExtent * 0.9) {
        state.isLoading = true;
        _getDoctors();
      }
    }
  }

  Future filterDoctors() async {
    state.doctors.clear();
    state.isLoading = true;
    if (state.searchController.text.isNotEmpty) {
      await db
          .collection("users")
          .where("role", isEqualTo: Role.Doctor.displayRole)
          .orderBy("created_at", descending: true)
          .withConverter(
            fromFirestore: DoctorUser.fromFirestore,
            toFirestore: (doctorUser, options) => doctorUser.toFirestore(),
          )
          .get()
          .then((querySnapshot) async {
        List<DoctorUser> doctors =
            await Future.wait(querySnapshot.docs.map((e) async {
          DoctorUser doctorUser = e.data();
          Map<String, dynamic> hospitalInfo =
              await _getInfoHospital(e.data().hospitalId!);
          doctorUser.hospitalName = hospitalInfo['hospital_name'];
          doctorUser.hospitalAddress = hospitalInfo['hospital_address'];
          return doctorUser;
        }));
        for (DoctorUser doctor in doctors) {
          String content = doctor.userName!.toLowerCase();
          String key = state.searchController.text.toLowerCase();
          if (content.contains(key)) {
            state.doctors.add(doctor);
          }
        }
        state.isLoading = false;
      });
    } else {
      state.isOnTapSearchText = false;
      _lastDocumentDoctor = null;
      _getDoctors();
    }
  }

  void navigateToDoctorDetail(String doctorId) {
    Get.toNamed(
      AppRoutes.DOCTOR_DETAIL,
      parameters: {
        'doctor_id': doctorId,
      },
    );
  }
}
