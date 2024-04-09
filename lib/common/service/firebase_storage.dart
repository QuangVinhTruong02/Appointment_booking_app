import 'dart:io';

import 'package:booking_doctor/common/utils/compress_file.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class FirebaseStorageService {
  Future getDefaultImgUrl(String ref, String child) async {
    final spaceRef = FirebaseStorage.instance.ref(ref).child(child);
    var str = await spaceRef.getDownloadURL();
    return str;
  }

  Future<String> uploadImg({required String ref,required File file}) async {
    var uuid = Uuid().v1();
    File compressFile = await compressImage(file.path);
    final spaceRef = await FirebaseStorage.instance.ref(ref).child(uuid);
    await spaceRef.putFile(
      compressFile,
      SettableMetadata(contentType: "image/png"),
    );
    String downloadUrl = await spaceRef.getDownloadURL();
    return downloadUrl;
  }

  Future<String?> uploadPdf(File file) async {
    var uuid = Uuid().v1();
    final ref = FirebaseStorage.instance.ref("pdfs").child(uuid);
    await ref.putFile(
      file,
      SettableMetadata(contentType: 'application/pdf'),
    );
    String? downloadUrl = await ref.getDownloadURL();
    return downloadUrl;
  }
}
