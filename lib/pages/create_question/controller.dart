import 'dart:async';
import 'dart:io';
import 'package:booking_doctor/common/entities/question.dart';
import 'package:booking_doctor/common/routes/routes.dart';
import 'package:booking_doctor/common/service/firebase_storage.dart';
import 'package:booking_doctor/common/store/store.dart';
import 'package:booking_doctor/common/widgets/show_dialog.dart';
import 'package:booking_doctor/pages/create_question/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:uuid/uuid.dart';

class CreateQuestionController extends GetxController {
  CreateQuestionController();
  final state = CreateQuestionState();
  final db = FirebaseFirestore.instance;

  StreamController _isAllInputValid = StreamController<void>.broadcast();

  @override
  void onInit() {
    super.onInit();
    _binds();
  }

  @override
  void dispose() {
    state.ageController.dispose();
    state.titleController.dispose();
    state.contentController.dispose();
    _isAllInputValid.close();
    state.scrollController.dispose();
    super.dispose();
  }

  _binds() {
    state.ageController.addListener(() => setAge(state.ageController.text));
    state.titleController
        .addListener(() => setTitle(state.titleController.text));
    state.contentController
        .addListener(() => setContent(state.contentController.text));
  }

  _validate() {
    _isAllInputValid.sink.add(null);
  }

  setAge(String value) {
    if (value.isEmpty) {
      state.errorAgeText = "Vui lòng nhập tuổi";
    } else if (int.parse(value) < 0 || int.parse(value) > 100) {
      state.errorAgeText = "Tuổi không hợp lệ";
    } else {
      state.errorAgeText = "";
    }
    _validate();
  }

  setTitle(String value) {
    if (value.isEmpty) {
      state.errorTitleText = "Vui lòng nhập tiêu đề";
    } else {
      state.errorTitleText = "";
    }
    _validate();
  }

  setContent(String value) {
    if (value.isEmpty && value.length < 30) {
      state.errorContentText = "Vui lòng nhập nội dung";
    } else {
      state.errorContentText = "";
    }
    _validate();
  }

  Future handleNextPagePhotoLibrary() async {
    await Get.toNamed(AppRoutes.PHOTO_LIBRARY)?.then((value) {
      if (value != null) {
        state.selectedMediumList = value;
      }
    });
  }

  Future handleNextPagePhotoView(Medium medium) async {
    await medium.getFile().then((imageFile) {
      Map<String, dynamic> parameters = {
        "image_file_path": imageFile.path,
        "is_photo_view": true
      };
      Get.toNamed(AppRoutes.PHOTO_VIEW, arguments: parameters);
      print(imageFile.path);
    });
  }

  bool _validateAllInput() {
    return state.titleController.text.isNotEmpty &&
        (state.contentController.text.isNotEmpty &&
            state.contentController.text.length > 30) &&
        (state.ageController.text.isNotEmpty &&
            int.parse(state.ageController.text) > 0 &&
            int.parse(state.ageController.text) < 100);
  }

  Future<List<String>> _getUrlImageList(List<Medium> mediums) async {
    List<String> imageUrlList = [];
    Iterable<Future<String>> mappedList =
        state.selectedMediumList.map((medium) async {
      File file = await medium.getFile();
      return await FirebaseStorageService()
          .uploadImg(ref: "questions", file: file);
    });
    Future<List<String>> futureList = Future.wait(mappedList);
    imageUrlList = await futureList;
    return imageUrlList;
  }

  Future handleCreatePost(BuildContext context) async {
    showLoadingDialog(context);
    var uuid = Uuid();
    var uuidV1 = uuid.v1();
    String avt_anonymous = await FirebaseStorageService()
        .getDefaultImgUrl("users", "personal_hygiene.png");
    List? imageUrlList = state.selectedMediumList.isNotEmpty
        ? await _getUrlImageList(state.selectedMediumList)
        : null;

    db
        .collection("questions")
        .withConverter(
          fromFirestore: Question.fromFirestore,
          toFirestore: (post, options) => post.toFirestore(),
        )
        .doc(uuidV1)
        .set(
          Question(
              questionId: uuidV1,
              title: state.titleController.text,
              content: state.contentController.text,
              age: int.parse(state.ageController.text),
              createdAt: Timestamp.now(),
              avatar: avt_anonymous,
              sexual: state.indexSexual == 0 ? "Nam" : "Nữ",
              userId: UserStore.to.token,
              images: imageUrlList,
              commentLength: 0,
              likes: [],
              replierId: null),
        )
        .whenComplete(() {
      Get.back();
      Get.back();
    });
  }

  void handleScroll() {
    state.scrollController.animateTo(
      state.scrollController.position.devicePixelRatio + 100.h,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Stream<bool> get outputIsAllValid =>
      _isAllInputValid.stream.map((event) => _validateAllInput());
}
