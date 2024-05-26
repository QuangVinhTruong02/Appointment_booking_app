import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailQuestionState {
  final _question = Rx<Question?>(null);
  final _comments = <Comment>[].obs;
  final _isLoading = false.obs;
  final _isLiked = false.obs;
  final _likesLength = 0.obs;
  TextEditingController replyController = TextEditingController();
  ScrollController scrollController = ScrollController();

  set question(Question? value) => _question.value = value;
  set isLoading(bool value) => _isLoading.value = value;
  set isLiked(bool value) => _isLiked.value = value;
  set likesLength(int value) => _likesLength.value = value;
  set comments(List<Comment> value) => _comments.value = value;

  Question? get question => _question.value;
  bool get isLoading => _isLoading.value;
  bool get isLiked => _isLiked.value;
  int get likesLength => _likesLength.value;
  List<Comment> get comments => _comments;
}
