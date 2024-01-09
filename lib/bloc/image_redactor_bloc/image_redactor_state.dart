import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImageRedactorState extends Equatable {
  final XFile? image;
  final bool isModificationMode;
  final double brightness;
  final double hue;
  final double saturation;

  const ImageRedactorState({
    this.brightness = 0,
    this.hue = 0,
    this.saturation = 0,
    required this.isModificationMode,
    required this.image,
  }) : super();

  @override
  List<Object?> get props => [isModificationMode, image];
}

class ImageRedactorInitialState extends ImageRedactorState {
  const ImageRedactorInitialState({
    required super.isModificationMode,
    required super.image,
  });

  @override
  List<Object?> get props => [isModificationMode, image];
}

class ImageRedactorLoadingState extends ImageRedactorState {
  const ImageRedactorLoadingState({
    required super.isModificationMode,
    required super.image,
  });

  @override
  List<Object?> get props => [isModificationMode, image];
}

class ImageRedactorPickedState extends ImageRedactorState {
  const ImageRedactorPickedState({
    super.brightness = 0,
    super.hue = 0,
    super.saturation = 0,
    required super.isModificationMode,
    required super.image,
  });

  @override
  List<Object?> get props =>
      [brightness, hue, saturation, isModificationMode, image];
}
