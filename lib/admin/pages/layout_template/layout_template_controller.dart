import 'package:booking_doctor/admin/pages/layout_template/layout_template_state.dart';
import 'package:booking_doctor/admin/pages/slide_bar/slide_bar_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class LayoutTemplateController extends ChangeNotifier {
  final SlideBarController slideBarController;
  LayoutTemplateController({required this.slideBarController}) {
    slideBarController.addListener(getCurrentTitle);
  }
  final state = LayoutTemplateState();
  void getCurrentTitle() {
    int index = slideBarController.index;
    switch (index) {
      case 0:
        state.title = "Tổng quan";
        break;
      case 1:
        state.title = "Danh sách bệnh viện";
        break;
      case 2:
        state.title = "Danh sách bác sĩ";
        break;
      case 3:
        state.title = "Thông tin cá nhân";
        break;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    slideBarController.removeListener(getCurrentTitle);
    super.dispose();
  }
}
