import 'dart:io';

abstract interface class ImageRedactorRepository {
  Future<void> selectImageFromGallery() async {}

  Future<void> selectImageFromCamera() async {}

  Future<File?> cropImage({required String imagePath}) async {
    return null;
  }
}
