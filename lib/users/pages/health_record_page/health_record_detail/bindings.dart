import 'package:booking_doctor/users/pages/health_record_page/health_record_detail/controller.dart';
import 'package:get/get.dart';

class HealthRecordDetailBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HealthRecordDetailController>(
        () => HealthRecordDetailController());
  }
}
