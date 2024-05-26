import 'package:booking_doctor/users/common/entities/health_record.dart';

import 'package:get/get.dart';

class HealthRecordState {
  var _healthRecords = <HealthRecord>[].obs;
  var _isLoading = true.obs;

  set healthRecords(List<HealthRecord> value) => _healthRecords.value = value;
  set isLoading(bool value) => _isLoading.value = value;

  bool get isLoading => _isLoading.value;
  List<HealthRecord> get healthRecords => _healthRecords;
}
