// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_redactor/bloc/image_redactor_bloc/image_redactor_event.dart';
import 'package:image_redactor/bloc/image_redactor_bloc/image_redactor_state.dart';
import 'package:image_redactor/implementations/image_redactor_impl.dart';

class ImageRedactorBloc extends Bloc<ImageRedactorEvent, ImageRedactorState> {
  final ImageRedactorImplementation _imageRedactorImplementation;

  ImageRedactorBloc({
    required ImageRedactorImplementation imageRedactorImplementation,
  })  : _imageRedactorImplementation = imageRedactorImplementation,
        super(const ImageRedactorInitialState(image: null)) {
    on<PickImageFromGalleryEvent>(_pickImageFromGallery);
    on<PickImageFromCameraEvent>(_pickImageFromCamera);
  }
  Future<void> _pickImageFromGallery(
      PickImageFromGalleryEvent pickImageFromCameraEvent,
      Emitter<ImageRedactorState> emitter) async {
    XFile? pickedImage =
        await _imageRedactorImplementation.selectImageFromGallery();

    if (pickedImage != null || pickedImage!.path.isNotEmpty) {
      emit(ImagePickedState(image: pickedImage));
    }
  }

  Future<void> _pickImageFromCamera(
      PickImageFromCameraEvent pickImageFromGalleryEvent,
      Emitter<ImageRedactorState> emitter) async {
    XFile? pickedImage =
        await _imageRedactorImplementation.selectImageFromCamera();

    if (pickedImage != null || pickedImage!.path.isNotEmpty) {
      emit(ImagePickedState(image: pickedImage));
    }
  }
}
