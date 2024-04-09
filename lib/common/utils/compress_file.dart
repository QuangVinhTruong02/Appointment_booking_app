import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

Future<File> compressImage(String imageUrl) async {
  XFile? result;
  final newPath = p.join(
    (await getTemporaryDirectory()).path,
    '${DateTime.now().millisecondsSinceEpoch.toString()}'
    '${p.extension(imageUrl)}',
  );
  result = await FlutterImageCompress.compressAndGetFile(
    imageUrl,
    newPath,
    format: p.extension(imageUrl) == ".png"
        ? CompressFormat.png
        : CompressFormat.jpeg,
  );
  return File(result!.path);
}
