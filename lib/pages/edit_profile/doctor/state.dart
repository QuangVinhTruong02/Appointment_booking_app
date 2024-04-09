import 'package:booking_doctor/common/entities/doctor.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileDoctorState {
  TextEditingController userNameTextController = TextEditingController();
  TextEditingController workExperienceController = TextEditingController();
  TextEditingController workPlaceController = TextEditingController();
  TextEditingController workAtController = TextEditingController();

  TextEditingController fromYearWorkProgressController =
      TextEditingController();
  TextEditingController toYearWorkProgressController = TextEditingController();
  TextEditingController majorController = TextEditingController();

  var _workExperienceList = <String>[].obs;
  var _workProgresList = <WorkProgress>[].obs;

  var _photoUrl = "".obs;
  var _isLoading = true.obs;

  set photoUrl(String url) => _photoUrl.value = url;
  set isLoading(bool value) => _isLoading.value = value;

  set workExperienceList(List<String> value) =>
      _workExperienceList.value = value;
  void addWorkExperience(String value) => _workExperienceList.add(value);
  void removeWorkExperience(int index) => _workExperienceList.removeAt(index);

  set workProgressList(List<WorkProgress> value) =>
      _workProgresList.value = value;
  void addWorkProgress(WorkProgress value) => _workProgresList.add(value);
  void removeWorkProgress(int index) => _workExperienceList.removeAt(index);
  void reorderWorkProgress(int oldIndex, int newIndex) {
    final item = _workProgresList.removeAt(oldIndex);
    _workProgresList.insert(newIndex, item);
  }

  String get photoUrl => _photoUrl.value;
  bool get isLoading => _isLoading.value;
  List<String> get workExperienceList => _workExperienceList;
  List<WorkProgress> get workProgressList => _workProgresList;
}
