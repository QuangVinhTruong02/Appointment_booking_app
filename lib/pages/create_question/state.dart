import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_gallery/photo_gallery.dart';

class CreateQuestionState {
  var _indexSexual = 0.obs;
  var _age = 20.obs;
  var _selectedMedium = <Medium>[].obs;
  TextEditingController ageController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  ScrollController scrollController = ScrollController();
  var _errorAgeText = "".obs;
  var _errorTitleText = "".obs;
  var _errorContentText = "".obs;

  set age(int value) => _age.value = value;
  set indexSexual(int value) => _indexSexual.value = value;
  set selectedMediumList(List<Medium> value) => _selectedMedium.value = value;
  set errorAgeText(String value) => _errorAgeText.value = value;
  set errorTitleText(String value) => _errorTitleText.value = value;
  set errorContentText(String value) => _errorContentText.value = value;

  int get indexSexual => _indexSexual.value;
  int get age => _age.value;
  List<Medium> get selectedMediumList => _selectedMedium;
  String get errorAgeText => _errorAgeText.value;
  String get errorTitleText => _errorTitleText.value;
  String get errorContentText => _errorContentText.value;
}
