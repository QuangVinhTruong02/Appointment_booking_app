import 'package:booking_doctor/users/common/entities/comment.dart';
import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:booking_doctor/users/common/store/store.dart';
import 'package:booking_doctor/users/common/utils/enum_extension.dart';
import 'package:booking_doctor/users/pages/detail_question/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class DetailQuestionController extends GetxController {
  DetailQuestionController();
  final state = DetailQuestionState();
  final db = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    _getCommentByQuestionId();
    _getQuestionById();
  }

  @override
  void dispose() {
    state.replyController.dispose();
    state.scrollController.dispose();

    super.dispose();
  }

  Future<Map<String, dynamic>?> _getInfomationDoctorById(String userId) {
    return db
        .collection("users")
        .doc(userId)
        .get()
        .then((value) => value.data());
  }

  _getQuestionById() {
    state.isLoading = true;
    String questionId = Get.arguments['question_id'];
    db
        .collection("questions")
        .doc(questionId)
        .withConverter(
            fromFirestore: Question.fromFirestore,
            toFirestore: (question, options) => question.toFirestore())
        .get()
        .then((snapshot) async {
      state.question = snapshot.data();
      if (state.question!.replierId != null) {
        await Future.value(state.question!.replierId)
            .then((value) => _getInfomationDoctorById(value ?? ""))
            .then((value) {
          state.question!.replierAvatar = value!['photo_url'];
          state.question!.replierName = value['user_name'];
        });
      }
      state.isLoading = false;
      state.isLiked = state.question!.likes.contains(UserStore.to.token);
      state.likesLength = state.question!.likes.length;
    });
  }

  _getCommentByQuestionId() {
    String questionId = Get.arguments['question_id'];
    db
        .collection("questions")
        .doc(questionId)
        .collection("comments")
        .withConverter(
            fromFirestore: Comment.fromFirestore,
            toFirestore: (comment, options) => comment.toFirestore())
        .orderBy("created_at", descending: false)
        .get()
        .then((value) {
      state.comments = value.docs.map((item) => item.data()).toList();
    });
  }

  bool isReply() {
    if (state.question?.userId == UserStore.to.token) {
      return true;
    }
    if (state.question?.replierId != null &&
        state.question?.replierId == UserStore.to.token) {
      return true;
    }
    if (state.question?.replierId == null &&
        UserStore.to.userLoginResponse.role == Role.Doctor.displayRole) {
      return true;
    }
    return false;
  }

  Future addCommentQuestion() async {
    var uuid = Uuid();
    var uuidV1 = uuid.v1();
    Comment comment = Comment(
      commentId: uuidV1,
      content: state.replyController.text.trim(),
      userId: UserStore.to.token,
      role: UserStore.to.userLoginResponse.role!,
      createdAt: Timestamp.now(),
    );
    await db
        .collection("questions")
        .doc(state.question!.questionId)
        .collection("comments")
        .withConverter(
          fromFirestore: Comment.fromFirestore,
          toFirestore: (comment, options) => comment.toFirestore(),
        )
        .doc(uuidV1)
        .set(comment);
    int commentLength = state.question!.commentLength + 1;
    await db.collection("questions").doc(state.question!.questionId).update({
      "commentLength": commentLength,
      if (state.question?.replierId == null &&
          UserStore.to.userLoginResponse.role == Role.Doctor.displayRole)
        "replier_id": UserStore.to.token
    });
    state.replyController.clear();
    state.comments.add(comment);
  }

  Future onTapComment(BuildContext context) async {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    //   double screenHeight = MediaQuery.of(context).size.height;
    //   double listViewHeight = screenHeight - keyboardHeight;

    // });
    state.scrollController.animateTo(
      state.scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
    //   Future.delayed(
    //     Duration(microseconds: 50),
    //     () {
    //       state.scrollController.animateTo(
    //         state.scrollController.position.maxScrollExtent,
    //         duration: const Duration(milliseconds: 300),
    //         curve: Curves.easeOut,
    //       );
    //     },
    //   );
    // });
    // state.scrollController.animateTo(
    //   1.0,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeOut,
    // );

    // state.scrollController.animateTo(
    //   state.scrollController.position.devicePixelRatio + 100.h,
    //   duration: const Duration(milliseconds: 300),
    //   curve: Curves.easeOut,
    // );
  }

  void handleLikeQuestion() {
    if (state.question!.likes.contains(UserStore.to.token)) {
      state.question!.likes.remove(UserStore.to.token);
      state.isLiked = false;
      state.likesLength--;
    } else {
      state.question!.likes.add(UserStore.to.token);
      state.isLiked = true;
      state.likesLength++;
    }
    db
        .collection("questions")
        .withConverter(
            fromFirestore: Question.fromFirestore,
            toFirestore: (question, options) => question.toFirestore())
        .doc(state.question!.questionId)
        .set(state.question!);
  }
}
