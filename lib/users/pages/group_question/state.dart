import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GroupQuestionState {
  TextEditingController searchController = TextEditingController();
  var _isOnTapSearchText = false.obs;

  var _filterQuestionList = <Question>[].obs;
  // var _filterQuestionList = <Question>[].obs;
  var _isLoading = false.obs;
  ScrollController scrollController = ScrollController();
  RefreshController refreshController = RefreshController();

  set filterQuestionList(List<Question> value) =>
      _filterQuestionList.value = value;
  set isLoading(bool value) => _isLoading.value = value;
  set isOnTapSearchText(bool value) => _isOnTapSearchText.value = value;

  List<Question> get filterQuestionList => _filterQuestionList;
  bool get isLoading => _isLoading.value;
  bool get isOnTapSearchText => _isOnTapSearchText.value;
}
