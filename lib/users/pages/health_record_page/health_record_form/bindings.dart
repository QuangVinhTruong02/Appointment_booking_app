import 'package:booking_doctor/users/pages/health_record_page/health_record_form/index.dart';
import 'package:get/get.dart';

class HealthRecordFormBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HealthRecordFormController>(() => HealthRecordFormController());
  }
}
