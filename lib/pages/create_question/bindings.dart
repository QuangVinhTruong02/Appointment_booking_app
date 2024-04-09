import 'package:booking_doctor/pages/create_question/controller.dart';
import 'package:get/get.dart';

class CreateQuestionBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateQuestionController>(() => CreateQuestionController());
  }
}
