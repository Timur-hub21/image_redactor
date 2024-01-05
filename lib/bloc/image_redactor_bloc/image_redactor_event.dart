import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

@immutable
sealed class ImageRedactorEvent {
  const ImageRedactorEvent();
}

final class PickImageFromGalleryEvent extends ImageRedactorEvent {
  final XFile? image;
  const PickImageFromGalleryEvent(this.image);
}

final class PickImageFromCameraEvent extends ImageRedactorEvent {
  final XFile? image;
  const PickImageFromCameraEvent(this.image);
}
