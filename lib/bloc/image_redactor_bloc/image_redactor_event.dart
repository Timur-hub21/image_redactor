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

final class CropImageEvent extends ImageRedactorEvent {
  final XFile? image;
  const CropImageEvent(this.image);
}

final class OnImageBrightnessIncrementEvent extends ImageRedactorEvent {
  final double brightness;
  const OnImageBrightnessIncrementEvent(this.brightness);
}

final class OnImageBrightnessDecrementEvent extends ImageRedactorEvent {
  final double brightness;
  const OnImageBrightnessDecrementEvent(this.brightness);
}

final class OnImageHueIncrementEvent extends ImageRedactorEvent {
  final double hue;
  const OnImageHueIncrementEvent(this.hue);
}

final class OnImageHueDecrementEvent extends ImageRedactorEvent {
  final double hue;
  const OnImageHueDecrementEvent(this.hue);
}

final class OnImageSaturationIncrementEvent extends ImageRedactorEvent {
  final double saturation;
  const OnImageSaturationIncrementEvent(this.saturation);
}

final class OnImageSaturationDecrementEvent extends ImageRedactorEvent {
  final double saturation;
  const OnImageSaturationDecrementEvent(this.saturation);
}
