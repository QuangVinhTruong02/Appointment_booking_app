import 'package:booking_doctor/pages/photo_view/index.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewController extends GetxController {
  PhotoViewController();
  PhotoViewState state = PhotoViewState();
  @override
  void onInit() {
    super.onInit();
    state.imageFilePath = Get.arguments['image_file_path']!;
    state.isPhotoView = Get.arguments['is_photo_view'];
    state.photoViewScaleStateController = PhotoViewScaleStateController();
    // state.photoViewControllerBase = PhotoViewControllerBase();
  }

  @override
  void dispose() {
    super.dispose();
    state.photoViewScaleStateController.dispose();
  }
}
