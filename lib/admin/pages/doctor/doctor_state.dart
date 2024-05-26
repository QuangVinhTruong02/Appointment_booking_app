import 'dart:typed_data';

import 'package:booking_doctor/admin/pages/doctor/doctor_controller.dart';
import 'package:booking_doctor/users/common/entities/doctor.dart';
import 'package:booking_doctor/users/common/entities/hospital.dart';
import 'package:flutter/material.dart';

class DoctorWebState {
  List<DoctorUser> _resultDoctors = [];
  List<String> _majors = [];
  List<Hospital> _hospitalNameList = [];
  List<WorkProgressController> _workExperiences = [];
  List<Key> _workExperienceKeys = [];
  String _selectedHospitalId = "";
  String _errorMess = "";
  bool _isLoading = true;
  Uint8List? _webImage;
  bool _pickedImg = false;

  TextEditingController userNameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController majorTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController workPlaceTextController = TextEditingController();
  TextEditingController searchTextController = TextEditingController();

  set webImage(Uint8List? value) => _webImage = value;
  set pickedImg(bool value) => _pickedImg = value;
  set selectedHospitalId(String id) => _selectedHospitalId = id;
  set resultDoctors(List<DoctorUser> value) => _resultDoctors = value;
  set isLoading(bool value) => _isLoading = value;
  set majors(List<String> value) => _majors = value;
  set workProgress(List<WorkProgressController> value) =>
      _workExperiences = value;
  set hospitalList(List<Hospital> value) => _hospitalNameList = value;
  set workExperienceKeys(List<Key> value) => _workExperienceKeys = value;
  set errorMess(String value) => _errorMess = value;

  List<DoctorUser> get resultDoctors => _resultDoctors;
  List<Hospital> get hospitalList => _hospitalNameList;
  bool get isLoading => _isLoading;
  List<String> get majors => _majors;
  List<WorkProgressController> get workProgress => _workExperiences;
  List<Key> get workExperienceKeys => _workExperienceKeys;
  String get errorMess => _errorMess;
  Uint8List? get webImage => _webImage;
  bool get pickedImg => _pickedImg;
  String get selectedHospitalId => _selectedHospitalId;
}
