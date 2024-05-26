import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

class FirebaseStorageWebService {
  // Future getDefaultImgUrl(String ref, String child) async {
  //   final spaceRef = FirebaseStorage.instance.ref(ref).child(child);
  //   var str = await spaceRef.getDownloadURL();
  //   return str;
  // }

  Future<String> uploadImg(
      {required String ref, required Uint8List unit8List}) async {
    var uuid = Uuid().v1();
    // File compressFile = await compressImage(file);
    final spaceRef = await FirebaseStorage.instance.ref(ref).child(uuid);
    await spaceRef.putData(
      unit8List,
      SettableMetadata(contentType: "image/png"),
    );
    String downloadUrl = await spaceRef.getDownloadURL();
    return downloadUrl;
  }

  Future deleteStorageById(String photoUrl, String ref) async {
    String ends = photoUrl.split("%")[1];
    String storageId = ends.split("?")[0].replaceRange(0, 2, "");
    await FirebaseStorage.instance.ref(ref).child(storageId).delete();
  }
}
