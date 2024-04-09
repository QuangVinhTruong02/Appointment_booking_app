import 'package:get/get.dart';

class ApplicationState {
  var _index = 0.obs;
  set pageIndex(int value) => _index.value = value;
  int get pageIndex => _index.value;
}
