import 'package:image_picker/image_picker.dart';

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
}
