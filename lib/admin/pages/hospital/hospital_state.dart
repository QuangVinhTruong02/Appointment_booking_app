import 'dart:typed_data';

import 'package:booking_doctor/admin/pages/hospital/hospital_controller.dart';
import 'package:booking_doctor/users/common/entities/hospital.dart';
import 'package:flutter/material.dart';

class HospitalState {
  List<Hospital> _resultHospitals = [];
  bool _isLoading = true;
  Uint8List? _webImage;
  bool _pickedImg = false;
  List<WorkTimeController> _workTimeControllers = [];
  List<Key> _workTimeKeys = [];
  String _errorMess = "";
  TextEditingController hospitalNameTextController = TextEditingController();
  TextEditingController hospitalAddressTextController = TextEditingController();
  TextEditingController searchTextController = TextEditingController();

  set workTimeControllers(List<WorkTimeController> value) =>
      _workTimeControllers = value;
  set isLoading(bool value) => _isLoading = value;
  set resultHospitals(List<Hospital> value) => _resultHospitals = value;
  set workTimeKeys(List<Key> value) => _workTimeKeys = value;
  set webImage(Uint8List? value) => _webImage = value;
  set pickedImg(bool value) => _pickedImg = value;
  set errorMess(String value) => _errorMess = value;

  List<Key> get workTimeKeys => _workTimeKeys;
  List<WorkTimeController> get workTimeControllers => _workTimeControllers;
  List<Hospital> get resultHospitals => _resultHospitals;
  bool get isLoading => _isLoading;
  Uint8List? get webImage => _webImage;
  bool get pickedImg => _pickedImg;
  String get errorMess => _errorMess;
}
