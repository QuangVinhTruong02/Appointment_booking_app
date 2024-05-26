import 'package:booking_doctor/users/common/entities/doctor.dart';
import 'package:booking_doctor/users/common/entities/hospital.dart';
import 'package:get/get.dart';

class HomePatientState {
  var _doctors = <DoctorUser>[].obs;
  var _isLoadingDoctor = true.obs;
  var _isLoadingHospital = true.obs;
  var _isLoading = true.obs;
  var _hospitals = <Hospital>[].obs;

  set hospitals(List<Hospital> value) => _hospitals.value = value;
  set isLoadingDoctor(bool value) => _isLoadingDoctor.value = value;
  set isLoadingHospital(bool value) => _isLoadingHospital.value = value;
  set isLoading(bool value) => _isLoading.value = value;
  set doctors(List<DoctorUser> value) => _doctors.value = value;

  List<DoctorUser> get doctors => _doctors;
  bool get isLoadingDoctor => _isLoadingDoctor.value;
  bool get isLoadingHospital => _isLoadingHospital.value;
  bool get isLoading => _isLoading.value;
  List<Hospital> get hospitals => _hospitals;
}
