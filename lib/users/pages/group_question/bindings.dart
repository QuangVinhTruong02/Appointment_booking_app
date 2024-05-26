// import 'package:booking_doctor/pages/group_question/all_question/index.dart';
import 'package:booking_doctor/users/pages/group_question/controller.dart';

import 'package:get/get.dart';

class GroupQuestionBindings implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<AllQuestionController>(() => AllQuestionController());
    Get.lazyPut<GroupQuestionController>(() => GroupQuestionController());
  }
}
