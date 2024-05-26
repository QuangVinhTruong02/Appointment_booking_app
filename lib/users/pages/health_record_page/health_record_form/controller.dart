import 'package:booking_doctor/users/common/entities/health_record.dart';
import 'package:booking_doctor/users/common/store/store.dart';
import 'package:booking_doctor/users/common/widgets/toast.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:booking_doctor/users/pages/doctor_schedules/state.dart';
import 'package:booking_doctor/users/pages/health_record_page/health_record_form/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';
import 'package:uuid/uuid.dart';

class HealthRecordFormController extends GetxController {
  var state = HealthRecordFormState();
  final db = FirebaseFirestore.instance;
  bool isEdit = false;
  HealthRecord? healthRecord = null;
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      healthRecord = Get.arguments['health_record'] as HealthRecord;
      isEdit = Get.arguments['is_edit'] as bool;
      state.nameController.text = healthRecord?.userName ?? "";
      state.DOBController.text = healthRecord?.DOB ?? "";
      state.IDCardController.text = healthRecord?.IDCard ?? "";
      state.genderController.text = healthRecord?.gender ?? "";
      state.phoneController.text =
          healthRecord?.phoneNumber?.replaceRange(0, 1, "") ?? "";
      state.addressController.text = healthRecord?.address ?? "";
    }
    _initCheckboxObjGender();
    state.nameController.addListener(() {
      setName();
    });
  }

  @override
  void dispose() {
    state.nameController.dispose();
    state.DOBController.dispose();
    state.genderController.dispose();
    state.phoneController.dispose();
    state.addressController.dispose();
    super.dispose();
  }

  void setName() {
    state.nameController.value = TextEditingValue(
        text: state.nameController.text.toUpperCase(),
        selection: state.nameController.selection);
  }

  _initCheckboxObjGender() {
    state.checkboxObjGender = [
      CheckBoxObject(name: "Nam", value: false),
      CheckBoxObject(name: "Nữ", value: false),
    ];
  }

  void onChangedCheckBoxGender(bool value, int index) {
    state.checkboxObjGender[index].value = value;
    state.genderController.text = state.checkboxObjGender[index].name;
    Get.back();
    state.checkboxObjGender.forEach((element) {
      if (element != state.checkboxObjGender[index]) {
        element.value = !value;
      }
    });
  }

  bool checkInputNotEmpty() {
    if (state.nameController.text.isEmpty) {
      toast(
          toastificationType: ToastificationType.error,
          message: "Vui lòng nhập họ và tên");
      return false;
    }
    if (state.DOBController.text.isEmpty) {
      toast(
          toastificationType: ToastificationType.error,
          message: "Vui lòng chọn ngày sinh");
      return false;
    }
    if (state.genderController.text.isEmpty) {
      toast(
          toastificationType: ToastificationType.error,
          message: "Vui lòng chọn ngày sinh");
      return false;
    }
    if (state.phoneController.text.isEmpty) {
      toast(
          toastificationType: ToastificationType.error,
          message: "Vui lòng nhập số điện thoại");
      return false;
    }
    if (state.addressController.text.isEmpty) {
      toast(
          toastificationType: ToastificationType.error,
          message: "Vui lòng nhập địa chỉ");
      return false;
    }
    return true;
  }

  Future handleCreateOrUpdateHealthRecord(BuildContext context) async {
    if (!checkInputNotEmpty()) {
      return;
    }
    print(state.phoneController.text);
    if (state.phoneController.text.length < 0 ||
        state.phoneController.text.length > 9) {
      toast(
          toastificationType: ToastificationType.error,
          message: "Số điện thoại không đúng định dạng");
      return;
    }
    showLoadingDialog(context);
    if (isEdit) {
      await updateHealthRecord();
    } else {
      await createHealthRecord();
    }
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future createHealthRecord() async {
    Uuid uuid = Uuid();
    String healthRecordId = uuid.v1();
    HealthRecord healthRecord = HealthRecord(
      healthRecordId: healthRecordId,
      patientId: UserStore.to.token,
      userName: state.nameController.text,
      DOB: state.DOBController.text,
      phoneNumber: "0${state.phoneController.text}",
      gender: state.genderController.text,
      address: state.addressController.text,
      createdAt: Timestamp.now(),
      IDCard: state.IDCardController.text.isNotEmpty
          ? state.IDCardController.text
          : null,
    );
    await db
        .collection("health_records")
        .withConverter(
          fromFirestore: HealthRecord.fromFirestore,
          toFirestore: (value, options) => value.toFiresotre(),
        )
        .doc(healthRecordId)
        .set(healthRecord);
  }

  Future updateHealthRecord() async {
    HealthRecord newHealthRecord = HealthRecord(
      healthRecordId: healthRecord!.healthRecordId,
      patientId: UserStore.to.token,
      userName: state.nameController.text,
      DOB: state.DOBController.text,
      phoneNumber: "0${state.phoneController.text}",
      gender: state.genderController.text,
      address: state.addressController.text,
      createdAt: Timestamp.now(),
      IDCard: state.IDCardController.text.isNotEmpty
          ? state.IDCardController.text
          : null,
    );
    await db
        .collection("health_records")
        .withConverter(
          fromFirestore: HealthRecord.fromFirestore,
          toFirestore: (value, options) => value.toFiresotre(),
        )
        .doc(healthRecord!.healthRecordId)
        .set(newHealthRecord);
  }
}
