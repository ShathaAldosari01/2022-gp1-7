import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class ImageUtils {
  static Future<File> imageToFile({required String imageName, required String ext}) async {
    var bytes = await rootBundle.load('assets/$imageName.$ext');
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/profile.png');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    return file;
  }
}


class AnotherClass {
  late File imagePlaceHolder;
  _setPlaceHolder() async {
    this.imagePlaceHolder = await ImageUtils.imageToFile(
        imageName: "photo_placeholder", ext: "jpg");
  }
  // ...
  // Image.file(this.imagePlaceHolder),


}