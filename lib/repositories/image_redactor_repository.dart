import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

abstract interface class ImageRedactorRepository {
  Future<void> selectImageFromGallery() async {}

  Future<void> selectImageFromCamera() async {}

  Future<Uint8List?> flipImageHorizontal(
    Uint8List imageData, {
    int width = 180,
    int height = 180,
  }) async {
    return null;
  }

  Future<Uint8List?> convertXFileToUint8List(XFile xFile) async {
    return null;
  }

  Future<XFile?> convertUint8ListToXFile(
    Uint8List uint8List,
    String fileName,
  ) async {
    return null;
  }
}
