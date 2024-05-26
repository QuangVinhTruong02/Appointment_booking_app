import 'package:booking_doctor/users/common/entities/health_record.dart';
import 'package:booking_doctor/users/common/routes/names.dart';
import 'package:booking_doctor/users/common/values/values.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:booking_doctor/users/pages/health_record_page/health_record_detail/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HealthRecordDetailController extends GetxController {
  final state = HealthRecordDetailState();
  final db = FirebaseFirestore.instance;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      state.healthRecord = Get.arguments as HealthRecord;
    }
  }

  void handleDeleteHealthRecord(BuildContext context) {
    showQuestionDialog(
      context: context,
      title: "Bạn muốn xoá hồ sơ này không",
      lottieAsset: AssetJsonValue.warning,
      onTapSubmit: () {
        showLoadingDialog(context);
        deleteHealthRecord();
        Navigator.of(context).popUntil((route) => route.isFirst);
      },
      onTapCancel: () {
        Get.back();
      },
    );
  }

  void handleEditHealthRecord() {
    Get.toNamed(
      AppRoutes.HEALTH_RECORD_FORM,
      arguments: {
        'health_record': state.healthRecord,
        'is_edit': true,
      },
    );
  }

  Future deleteHealthRecord() async {
    await db
        .collection("health_records")
        .doc(state.healthRecord?.healthRecordId)
        .delete();
  }
}
