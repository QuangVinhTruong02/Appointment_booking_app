import 'package:booking_doctor/users/common/entities/health_record.dart';
import 'package:get/get.dart';

class HealthRecordDetailState {
  var _healthRecord = Rxn<HealthRecord>();

  set healthRecord(HealthRecord? value) => _healthRecord.value = value;

  HealthRecord? get healthRecord => _healthRecord.value;
}
