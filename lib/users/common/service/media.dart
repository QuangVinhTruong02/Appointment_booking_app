import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:booking_doctor/users/common/widgets/widgets.dart';
import 'package:toastification/toastification.dart';

class MediaService {
  Future<bool> _promptPermissionSetting() async {
    if (Platform.isAndroid) {
      if (await Permission.storage.request().isGranted ||
          await Permission.photos.request().isGranted) {
        return true;
      }
    }
    return false;
  }

  Future<List<Album>> initAlbums() async {
    if (await _promptPermissionSetting()) {
      List<Album> albums =
          await PhotoGallery.listAlbums(mediumType: MediumType.image);
      return albums;
    }
    throw toast(
        toastificationType: ToastificationType.error, message: "Hãy thử lại");
  }

  Future<List<Medium>> getMediums(Album album) async {
    MediaPage mediaPage = await album.listMedia();
    return mediaPage.items;
  }
}
