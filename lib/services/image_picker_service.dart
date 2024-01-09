import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_cropper/image_cropper.dart';

class ImagePickerService {
  final ImagePicker imagePicker = ImagePicker();
  final ImageCropper imageCropper = ImageCropper();

  ImagePickerService();

  Future<XFile?> selectImageFromGallery() async {
    try {
      final XFile? image =
          await imagePicker.pickImage(source: ImageSource.gallery);

      if (image == null || image.path.isEmpty) {
        return null;
      }

      return image;
    } catch (e) {
      throw Exception("Exception is: $e");
    }
  }

  Future<XFile?> selectImageFromCamera() async {
    try {
      final XFile? image =
          await imagePicker.pickImage(source: ImageSource.camera);
      return image;
    } catch (e) {
      throw Exception("Exception is: $e");
    }
  }

  Future<File?> cropImage(String imagePath) async {
    try {
      File? convertedFile;

      CroppedFile? croppedFile = await imageCropper.cropImage(
        sourcePath: imagePath,
        aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
        maxWidth: 512,
        maxHeight: 512,
      );
      if (croppedFile == null || croppedFile.path.isEmpty) {
        return null;
      } else {
        convertedFile = await copyCroppedFile(croppedFile.path);
      }
      return convertedFile;
    } catch (e) {
      throw Exception('Не удалось обрезать изображение: $e');
    }
  }

  Future<File> copyCroppedFile(String croppedFilePath) async {
    final Directory appDocDir = await getTemporaryDirectory();
    final String appDocPath = appDocDir.path;
    final String newFilePath = '$appDocPath/cropped_image.jpg';

    final File croppedFile = File(croppedFilePath);
    final File newFile = await croppedFile.copy(newFilePath);

    return newFile;
  }
}
