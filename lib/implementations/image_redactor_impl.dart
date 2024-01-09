import 'dart:io';
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
  Future<File?> cropImage({required String imagePath}) async {
    final File? croppedFile = await imagePickerService.cropImage(imagePath);

    if (croppedFile == null || croppedFile.path.isEmpty) {
      return null;
    } else {
      return croppedFile;
    }
  }
}
