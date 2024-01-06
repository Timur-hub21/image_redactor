// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_redactor/bloc/image_redactor_bloc/image_redactor_event.dart';
import 'package:image_redactor/bloc/image_redactor_bloc/image_redactor_state.dart';
import 'package:image_redactor/implementations/image_redactor_impl.dart';
import 'package:image_redactor/utils/file_name_generator.dart';
import 'package:path_provider/path_provider.dart';

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
    Emitter<ImageRedactorState> emitter,
  ) async {
    emit(const ImageRedactorLoadingState(image: null));

    Future.delayed(const Duration(seconds: 4));

    final XFile? pickedImage =
        await _imageRedactorImplementation.selectImageFromGallery();
    print('Bloc: $pickedImage');

    if (pickedImage != null || pickedImage!.path.isNotEmpty) {
      final Uint8List? convertedImage = await _imageRedactorImplementation
          .convertXFileToUint8List(pickedImage);

      final Uint8List? modifiedImage = await _imageRedactorImplementation
          .flipImageHorizontal(convertedImage!);

      final fileNameGenerator = generateUniqueFileName();

      print('Bloc: $fileNameGenerator');

      final XFile? finalImage = await _imageRedactorImplementation
          .convertUint8ListToXFile(modifiedImage!, fileNameGenerator);

      emit(ImagePickedState(image: finalImage));
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
