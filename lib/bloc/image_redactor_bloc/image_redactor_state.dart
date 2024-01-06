import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class ImageRedactorState extends Equatable {
  final XFile? image;
  const ImageRedactorState({required this.image}) : super();

  @override
  List<XFile?> get props => [image];
}

class ImageRedactorInitialState extends ImageRedactorState {
  const ImageRedactorInitialState({required super.image});

  @override
  List<XFile?> get props => [image];
}

class ImageRedactorLoadingState extends ImageRedactorState {
  const ImageRedactorLoadingState({required super.image});

  @override
  List<XFile?> get props => [image];
}

class ImagePickedState extends ImageRedactorState {
  const ImagePickedState({required super.image});

  @override
  List<XFile?> get props => [image];
}
