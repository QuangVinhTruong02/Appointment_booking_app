import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewState {
  var _imageFilePath = "".obs;
  var _isPhotoView = false.obs;
  late PhotoViewScaleStateController photoViewScaleStateController;
  late PhotoViewControllerBase photoViewControllerBase;

  set imageFilePath(String value) => _imageFilePath.value = value;
  set isPhotoView(bool value) => _isPhotoView.value = value;

  String get imageFilePath => _imageFilePath.value;
  bool get isPhotoView => _isPhotoView.value;
}
