import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:image_redactor/repositories/image_redactor_repository.dart';
import 'package:image_redactor/services/image_picker_service.dart';

class ImageRedactorImplementation implements ImageRedactorRepository {
  final ImagePickerService imagePickerService;
  const ImageRedactorImplementation(this.imagePickerService);

  @override
  Future<XFile?> selectImageFromGallery() async {
    XFile? image = await imagePickerService.selectImageFromGallery();
    return image;
  }

  @override
  Future<XFile?> selectImageFromCamera() async {
    XFile? image = await imagePickerService.selectImageFromCamera();
    return image;
  }

  @override
  Future<Uint8List?> convertXFileToUint8List(XFile xFile) async {
    final Uint8List? selectedImage =
        await imagePickerService.convertXFileToUint8List(xFile);
    return selectedImage;
  }

  @override
  Future<XFile?> convertUint8ListToXFile(
      Uint8List uint8List, String fileName) async {
    final XFile? modifiedImage =
        await imagePickerService.convertUint8ListToXFile(uint8List, fileName);
    return modifiedImage;
  }

  @override
  Future<Uint8List?> flipImageHorizontal(
    Uint8List imageData, {
    int width = 180,
    int height = 180,
  }) async {
    final Uint8List flippedImage = await imagePickerService.flipVertical(
      imageData,
    );
    return flippedImage;
  }
}
