import 'package:booking_doctor/users/pages/detail_question/controller.dart';

import 'package:get/get.dart';

class DetailQuestionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailQuestionController>(() => DetailQuestionController());
  }
}
