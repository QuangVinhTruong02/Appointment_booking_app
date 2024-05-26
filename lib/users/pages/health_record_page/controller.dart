import 'package:booking_doctor/users/common/entities/health_record.dart';
import 'package:booking_doctor/users/common/routes/routes.dart';
import 'package:booking_doctor/users/common/store/store.dart';
import 'package:booking_doctor/users/pages/health_record_page/index.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HeathRecordController extends GetxController {
  final db = FirebaseFirestore.instance;
  final state = HealthRecordState();

  @override
  void onInit() {
    super.onInit();
    getHealthRecord();
  }

  Future navigateHealthRecordFormPage() async {
    await Get.toNamed(
      AppRoutes.HEALTH_RECORD_FORM,
    );
    getHealthRecord();
  }

  Future navigateHealthRecordDetailPage(HealthRecord healthRecord) async {
    await Get.toNamed(
      AppRoutes.HEALTH_RECORD_DETAIL,
      arguments: healthRecord,
    );
    getHealthRecord();
  }

  Future getHealthRecord() async {
    state.isLoading = true;
    await db
        .collection("health_records")
        .withConverter(
          fromFirestore: HealthRecord.fromFirestore,
          toFirestore: (value, options) => value.toFiresotre(),
        )
        .where("patient_id", isEqualTo: UserStore.to.token)
        .orderBy("created_at", descending: true)
        .get()
        .then((snapshot) {
      state.healthRecords = snapshot.docs.map((e) => e.data()).toList();
      state.isLoading = false;
    });
  }
}
