import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

extension XFileExtension on XFile {
  Future<File?> compress({int quality = 25}) async {
    final lastIndex = path.lastIndexOf('.');
    final splitted = path.substring(0, (lastIndex));

    final outPath = "${splitted}_out.jpeg";
    var result = await FlutterImageCompress.compressAndGetFile(
      path,
      outPath,
      quality: quality,
    );

    return result;
  }
}
