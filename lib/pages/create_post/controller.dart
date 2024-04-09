// import 'dart:async';
// import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:job_search/common/widgets/widgets.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:uuid/data.dart';
// import 'package:uuid/uuid.dart';
// import 'package:get/get.dart';
// import 'package:path/path.dart' as p;
// import 'package:photo_gallery/photo_gallery.dart';
// import 'package:job_search/common/entities/entities.dart';
// import 'package:job_search/common/routes/routes.dart';
// import 'package:job_search/common/store/store.dart';
// import 'package:job_search/pages/create_post/index.dart';

// class CreatePostController extends GetxController {
//   CreatePostController();
//   CreatePostState state = CreatePostState();
//   StreamController _isInputValidStreamController = StreamController<void>();
//   final db = FirebaseFirestore.instance;

//   late UserLoginResponse _profile;
//   @override
//   void onInit() {
//     super.onInit();
//     _profile = UserStore.to.userLoginResponse;
//   }

//   @override
//   void dispose() {
//     state.textEditingController.dispose();
//     _isInputValidStreamController.close();
//     super.dispose();
//   }

//   Future handleOpenLibrary() async {
//     await Get.toNamed(AppRoutes.PHOTO_LIBRARY)?.then((value) {
//       state.mediumList.value = value;
//       validate();
//     });
//   }

//   void handleClose() {
//     Get.back();
//   }

//   void handleRemoveMedium(Medium medium) {
//     state.mediumList.remove(medium);
//     validate();
//   }

//   bool _isInputValid() {
//     return state.mediumList.isNotEmpty ||
//         state.textEditingController.value.text.isNotEmpty;
//   }

//   void validate() {
//     _isInputValidStreamController.sink.add(null);
//   }

//   Future<File> _compressImage(String imageUrl) async {
//     XFile? result;
//     final newPath = p.join(
//       (await getTemporaryDirectory()).path,
//       '${DateTime.now().millisecondsSinceEpoch.toString()}'
//       '${p.extension(imageUrl)}',
//     );
//     result = await FlutterImageCompress.compressAndGetFile(
//       imageUrl,
//       newPath,
//       format: p.extension(imageUrl) == ".png"
//           ? CompressFormat.png
//           : CompressFormat.jpeg,
//     );
//     return File(result!.path);
//   }

//   Future _uploadImageToStorage(String imageUrl) async {
//     try {
//       var dateTime = DateTime.now().millisecondsSinceEpoch;
//       String namePath = '${dateTime}${p.extension(imageUrl)}';
//       var ref =
//           FirebaseStorage.instance.ref().child("images").child('${namePath}');
//       File compressFile = await _compressImage(imageUrl);
//       await ref.putFile(
//         compressFile,
//         SettableMetadata(contentType: 'image/png'),
//       );
//       String downloadUrl = await ref.getDownloadURL();
//       return downloadUrl;
//     } catch (e) {
//       print("Error upload: $e");
//     }
//   }

//   Future<List<String>> _getUrlImageList(List<Medium> mediums) async {
//     List<String> imageUrlList = [];
//     Iterable<Future<String>> mappedList = state.mediumList.map((medium) async {
//       File file = await medium.getFile();
//       return await _uploadImageToStorage(file.path);
//     });
//     Future<List<String>> futureList = Future.wait(mappedList);
//     imageUrlList = await futureList;
//     return imageUrlList;
//   }

//   Future handleCreatePost(BuildContext context) async {
//     try {
//       showLoadingDialog(context);

//       var uuid = Uuid();
//       var uidv1 = uuid.v1(
//         config: V1Options(
//           0x1234,
//           DateTime.now().millisecondsSinceEpoch,
//           5678,
//           [0x01, 0x23, 0x45, 0x67, 0x89, 0xab],
//           null,
//         ),
//       );
//       String userPath = "users/${UserStore.to.token}";
//       List<String> imageUrlList = await _getUrlImageList(state.mediumList);
//       JobData postData = JobData(
//         id: uidv1,
//         caption: state.textEditingController.text,
//         imageList: imageUrlList,
//         createdAt: Timestamp.now(),
//         userReference: userPath,
//       );
//       await db
//           .collection("posts")
//           .withConverter(
//             fromFirestore: JobData.fromFirestore,
//             toFirestore: (postData, options) => postData.toJson(),
//           )
//           .doc(uidv1)
//           .set(postData);
//       Get.offAllNamed(AppRoutes.APPLICATION);
//     } catch (e) {
//       toastInfo(msg: e.toString());
//       print("Error: ${e}");
//     }
//   }

//   UserLoginResponse get profile => _profile;
//   Stream<bool> get outputInputValid =>
//       _isInputValidStreamController.stream.map((event) => _isInputValid());
// }
