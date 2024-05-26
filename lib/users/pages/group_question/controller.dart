import 'package:booking_doctor/users/common/entities/entities.dart';
import 'package:booking_doctor/users/common/routes/routes.dart';
import 'package:booking_doctor/users/common/store/store.dart';
import 'package:booking_doctor/users/pages/group_question/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class GroupQuestionController extends GetxController {
  final state = GroupQuestionState();
  final db = FirebaseFirestore.instance;

  DocumentSnapshot? _lastDocumentSnapshot;

  @override
  void onInit() {
    super.onInit();
    state.isLoading = true;
    getQuestions();
    state.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    state.scrollController.removeListener(_onScroll);
    state.scrollController.dispose();
    state.refreshController.dispose();
    state.searchController.dispose();
    super.dispose();
  }

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    state.refreshController.refreshCompleted();
    _lastDocumentSnapshot = null;
    state.filterQuestionList.clear();
    state.isLoading = true;
    getQuestions();
    state.scrollController.addListener(_onScroll);
  }

  Future getQuestions() async {
    state.isLoading = true;
    var query = await db
        .collection("questions")
        .withConverter(
            fromFirestore: Question.fromFirestore,
            toFirestore: (question, options) => question.toFirestore())
        .orderBy("created_at", descending: true)
        .limit(3);
    if (_lastDocumentSnapshot != null) {
      query = query.startAfter([_lastDocumentSnapshot!['created_at']]);
    }
    query.get().then((snapshot) async {
      if (snapshot.docs.isNotEmpty && state.isLoading) {
        _lastDocumentSnapshot = snapshot.docs[snapshot.docs.length - 1];
        List<Question> questions =
            await Future.wait(snapshot.docs.map((e) async {
          Question question = e.data();
          if (question.replierId != null) {
            Map<String, dynamic>? doctorInfo =
                await _getInfomationDoctorById(question.replierId ?? "");
            question.replierAvatar = doctorInfo!['photo_url'];
            question.replierName = doctorInfo['user_name'];
          }
          return question;
        }));
        state.filterQuestionList.addAll(questions);
        state.isLoading = false;
      }
      if (snapshot.docs.isEmpty) {
        state.scrollController.removeListener(_onScroll);
        state.isLoading = false;
      }
    });
  }

  Future<Map<String, dynamic>?> _getInfomationDoctorById(String userId) {
    return db
        .collection("users")
        .doc(userId)
        .get()
        .then((value) => value.data());
  }

  void handleLikeQuestion(Question question) {
    if (question.likes.contains(UserStore.to.token)) {
      question.likes.remove(UserStore.to.token);
    } else {
      question.likes.add(UserStore.to.token);
    }
    db
        .collection("questions")
        .withConverter(
            fromFirestore: Question.fromFirestore,
            toFirestore: (question, options) => question.toFirestore())
        .doc(question.questionId)
        .set(question);
  }

  void handleNextPageDetailQuestion(String questionId) {
    Get.toNamed(AppRoutes.DETAIL_QUESTION, arguments: {
      "question_id": questionId,
    });
    // Get.toNamed(AppRoutes.DETAIL);
  }

  void _onScroll() {
    if (!state.isLoading) {
      if (state.scrollController.position.pixels <=
          state.scrollController.position.maxScrollExtent * 0.9) {
        state.isLoading = true;
        getQuestions();
      }
    }
  }

  void handleNavigateCreateQuestion() {
    Get.toNamed(AppRoutes.CREATE_QUESTION);
  }

  Future filterQuestions() async {
    state.filterQuestionList.clear();
    state.isLoading = true;
    if (state.searchController.text.isNotEmpty) {
      await db
          .collection("questions")
          .orderBy("created_at", descending: true)
          .withConverter(
            fromFirestore: Question.fromFirestore,
            toFirestore: (question, options) => question.toFirestore(),
          )
          .get()
          .then((querySnapshot) {
        var doc = querySnapshot.docs;
        List<Question> questions = doc.map((item) => item.data()).toList();
        for (Question question in questions) {
          String content = question.content.toLowerCase();
          String title = question.title.toLowerCase();
          String key = state.searchController.text.toLowerCase();
          if (content.contains(key) || title.contains(key)) {
            state.filterQuestionList.add(question);
          }
        }
        state.isLoading = false;
      });
    } else {
      state.isOnTapSearchText = false;
      _lastDocumentSnapshot = null;
      getQuestions();
    }
  }

  void onTapOutSide() {
    Get.focusScope!.unfocus();
    if (state.searchController.text.isEmpty) {
      state.isOnTapSearchText = false;
    }
  }

  void onTapCloseButton() {
    _lastDocumentSnapshot = null;
    state.searchController.clear();
    state.filterQuestionList.clear();
    state.isOnTapSearchText = false;
    getQuestions();
  }
}
