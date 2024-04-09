import 'dart:io';

import 'package:booking_doctor/pages/photo_library/state.dart';
import 'package:get/get.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:booking_doctor/common/service/service.dart';


class PhotoLibraryController extends GetxController {
  PhotoLibraryController();
  PhotoLibraryState state = PhotoLibraryState();
  final _selectedMediums = <Medium>[].obs;
  var fileList = <File>[].obs;
  @override
  void onInit() {
    super.onInit();
    state.isLoading = true;
    _initAlbum();
  }

  Future _initAlbum() async {
    await MediaService().initAlbums().then((albumList) async {
      state.albums = albumList;
      state.selectedAlbum = albumList[0];
      state.mediums = await MediaService().getMediums(albumList[0]);
      state.isLoading = false;
    });
  }

  Future<void> handleSetAlbum(Album album) async {
    state.selectedAlbum = album;
    state.mediums = await MediaService().getMediums(album);
  }

  void handleAddListMedium(Medium medium) {
    if (_selectedMediums.contains(medium)) {
      _selectedMediums.remove(medium);
    } else {
      _selectedMediums.add(medium);
    }
  }

  void handleSelectedImage() {
    Get.back(result: _selectedMediums);
  }

  List<Medium> get selectedMediums => _selectedMediums;
}
