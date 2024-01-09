// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';
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
        super(const ImageRedactorInitialState(
            isModificationMode: false, image: null)) {
    on<PickImageFromGalleryEvent>(_pickImageFromGallery);
    on<PickImageFromCameraEvent>(_pickImageFromCamera);
    on<CropImageEvent>(_cropImage);
    on<OnImageBrightnessIncrementEvent>(_onBrightnessIncrement);
    on<OnImageBrightnessDecrementEvent>(_onBrightnessDecrement);
    on<OnImageHueIncrementEvent>(_onHueIncrement);
    on<OnImageHueDecrementEvent>(_onHueDecrement);
    on<OnImageSaturationIncrementEvent>(_onSaturationIncrement);
    on<OnImageSaturationDecrementEvent>(_onSaturationDecrement);
  }

  Future<void> _pickImageFromGallery(
    PickImageFromGalleryEvent pickImageFromCameraEvent,
    Emitter<ImageRedactorState> emitter,
  ) async {
    emit(const ImageRedactorLoadingState(
        isModificationMode: false, image: null));

    final XFile? pickedImage =
        await _imageRedactorImplementation.selectImageFromGallery();

    if (pickedImage != null && pickedImage.path.isNotEmpty) {
      emit(ImageRedactorPickedState(
          isModificationMode: true, image: pickedImage));
    } else {
      emit(const ImageRedactorInitialState(
          isModificationMode: false, image: null));
    }
  }

  Future<void> _pickImageFromCamera(
      PickImageFromCameraEvent pickImageFromGalleryEvent,
      Emitter<ImageRedactorState> emitter) async {
    emit(const ImageRedactorLoadingState(
        isModificationMode: false, image: null));

    final XFile? pickedImage =
        await _imageRedactorImplementation.selectImageFromCamera();

    if (pickedImage != null && pickedImage.path.isNotEmpty) {
      emit(ImageRedactorPickedState(
          isModificationMode: true, image: pickedImage));
    } else {
      emit(const ImageRedactorInitialState(
          isModificationMode: false, image: null));
    }
  }

  Future<void> _cropImage(CropImageEvent cropImageEvent,
      Emitter<ImageRedactorState> emitter) async {
    final XFile pickedImage = state.image!;

    final File? image = await _imageRedactorImplementation.cropImage(
        imagePath: pickedImage.path);

    if (image == null || image.path.isEmpty) {
      emit(const ImageRedactorInitialState(
          isModificationMode: false, image: null));
    } else {
      final XFile croppedImage = XFile(image.path);

      emit(ImageRedactorPickedState(
          isModificationMode: true, image: croppedImage));
    }
  }

  void _onBrightnessIncrement(
      OnImageBrightnessIncrementEvent onImageBrightnessChangedEvent,
      Emitter<ImageRedactorState> emitter) {
    final XFile pickedImage = state.image!;

    emit(ImageRedactorPickedState(
      brightness: state.brightness + 0.1,
      isModificationMode: false,
      image: pickedImage,
    ));
  }

  void _onBrightnessDecrement(
      OnImageBrightnessDecrementEvent onImageBrightnessDecrementEvent,
      Emitter<ImageRedactorState> emitter) {
    final XFile pickedImage = state.image!;

    emit(ImageRedactorPickedState(
      brightness: state.brightness - 0.1,
      isModificationMode: false,
      image: pickedImage,
    ));
  }

  void _onHueIncrement(OnImageHueIncrementEvent onImageHueIncrementEvent,
      Emitter<ImageRedactorState> emitter) {
    final XFile pickedImage = state.image!;

    emit(ImageRedactorPickedState(
      hue: state.hue + 0.1,
      isModificationMode: false,
      image: pickedImage,
    ));
  }

  void _onHueDecrement(OnImageHueDecrementEvent onImageHueDecrementEvent,
      Emitter<ImageRedactorState> emitter) {
    final XFile pickedImage = state.image!;

    emit(ImageRedactorPickedState(
      hue: state.hue - 0.1,
      isModificationMode: false,
      image: pickedImage,
    ));
  }

  void _onSaturationIncrement(
      OnImageSaturationIncrementEvent onImageSaturationIncrementEvent,
      Emitter<ImageRedactorState> emitter) {
    final XFile pickedImage = state.image!;

    emit(ImageRedactorPickedState(
      saturation: state.saturation + 0.1,
      isModificationMode: false,
      image: pickedImage,
    ));
  }

  void _onSaturationDecrement(
      OnImageSaturationDecrementEvent onImageSaturationDecrementEvent,
      Emitter<ImageRedactorState> emitter) {
    final XFile pickedImage = state.image!;

    emit(ImageRedactorPickedState(
      saturation: state.saturation - 0.1,
      isModificationMode: false,
      image: pickedImage,
    ));
  }
}
