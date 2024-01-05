abstract interface class ImageRedactorRepository {
  Future<void> selectImageFromGallery() async {}

  Future<void> selectImageFromCamera() async {}
}
