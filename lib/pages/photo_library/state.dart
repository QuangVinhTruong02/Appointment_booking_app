import 'package:get/get.dart';
import 'package:photo_gallery/photo_gallery.dart';

class PhotoLibraryState {
  var _albums = Rx<List<Album>>([]);
  var _selectedAlbum = Rx<Album?>(null);
  var _mediums = Rx<List<Medium>>([]);
  var _isLoading = true.obs;

  

  set albums(List<Album> list) => _albums.value = list;
  set selectedAlbum(Album value) => _selectedAlbum.value = value;
  set mediums(List<Medium> list) => _mediums.value = list;
  set isLoading(bool value) => _isLoading.value = value;

  List<Album> get albums => _albums.value;
  Album get selectedAlbum => _selectedAlbum.value!;
  List<Medium> get mediums => _mediums.value;
  bool get isLoading => _isLoading.value;
}
