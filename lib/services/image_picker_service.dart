import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class ImagePickerService {
  final ImagePicker imagePicker = ImagePicker();

  ImagePickerService();

  Future<XFile?> selectImageFromGallery() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null || image.path.isEmpty) return null;
    return image;
  }

  Future<XFile?> selectImageFromCamera() async {
    XFile? image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image == null || image.path.isEmpty) return null;
    return image;
  }

  Future<Uint8List?> convertXFileToUint8List(XFile xFile) async {
    try {
      File file = File(xFile.path);
      if (await file.exists()) {
        List<int> bytes = await file.readAsBytes();
        return Uint8List.fromList(bytes);
      }
    } catch (e) {
      debugPrint('Произошла ошибка при конвертации XFile в Uint8List: $e');
    }
    return null;
  }

  // Future<XFile?> convertUint8ListToXFile(
  //   Uint8List uint8List,
  //   String fileName,
  // ) async {
  //   try {
  //     /// Получаем директорию приложения для сохранения файла
  //     final Directory appDirectory = await getApplicationDocumentsDirectory();
  //     final String filePath = '${appDirectory.path}/$fileName';

  //     /// Создаем и записываем данные в файл
  //     await File(filePath).writeAsBytes(uint8List);

  //     /// Создаем XFile на основе файла
  //     final XFile xFile = XFile(filePath);
  //     return xFile;
  //   } catch (e) {
  //     debugPrint('Произошла ошибка при конвертации Uint8List в XFile: $e');
  //     return null;
  //   }
  // }

  Future<XFile?> convertUint8ListToXFile(
    Uint8List uint8List,
    String fileName,
  ) async {
    try {
      final Directory appDirectory = await getApplicationDocumentsDirectory();
      final String filePath = '${appDirectory.path}/$fileName';

      await File(filePath).writeAsBytes(uint8List);

      return XFile(filePath);
    } catch (e) {
      debugPrint('Произошла ошибка при конвертации Uint8List в XFile: $e');
      return null;
    }
  }

  Future<Uint8List> flipVertical(
    Uint8List imageData, {
    int width = 180,
    int height = 180,
  }) async {
    img.Image image = img.decodeImage(imageData)!;

    // Выполнение вертикального флипа
    img.Image flippedImage = img.flipVertical(image);

    // Преобразование изображения в байты
    Uint8List flippedImageData =
        Uint8List.fromList(img.encodePng(flippedImage));

    return flippedImageData;
  }
}
