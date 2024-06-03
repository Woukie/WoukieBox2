import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

// https://stackoverflow.com/questions/52353764/how-do-i-get-the-assets-file-path-in-flutter
Future<File> getImageFileFromAssets(String path) async {
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  var filePath = "$tempPath/$path";
  var file = File(filePath);
  if (file.existsSync()) {
    return file;
  } else {
    final byteData = await rootBundle.load('assets/$path');
    final buffer = byteData.buffer;
    await file.create(recursive: true);
    return file.writeAsBytes(
        buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
  }
}
