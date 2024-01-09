// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:image_redactor/bloc/image_redactor_bloc/image_redactor_bloc.dart';
import 'package:image_redactor/bloc/image_redactor_bloc/image_redactor_event.dart';
import 'package:image_redactor/bloc/image_redactor_bloc/image_redactor_state.dart';
import 'package:image_redactor/components/action_button.dart';
import 'package:themed/themed.dart';

class ImageRedactorScreen extends StatelessWidget {
  const ImageRedactorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageRedactorBloc, ImageRedactorState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: const SafeArea(
            child: ImageRedactorBody(),
          ),
          floatingActionButton: const ImageRedactorFab(),
        );
      },
    );
  }
}

class ImageRedactorBody extends StatelessWidget {
  const ImageRedactorBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageRedactorBloc imageRedactorBloc =
        context.read<ImageRedactorBloc>();

    return BlocConsumer<ImageRedactorBloc, ImageRedactorState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ImageRedactorLoadingState) {
          return const Center(
            child: Text('Loading...'),
          );
        } else if (state is ImageRedactorPickedState) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ActionButton(
                        icon: const Icon(Icons.crop, size: 26),
                        onTap: () => imageRedactorBloc.add(
                          CropImageEvent(state.image),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text('Press to crop selected Image')
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ActionButton(
                      icon: const Icon(Icons.remove, size: 26),
                      onTap: () => imageRedactorBloc.add(
                        OnImageBrightnessDecrementEvent(state.brightness),
                      ),
                    ),
                    const Text('Change brightness of selected Image'),
                    ActionButton(
                      icon: const Icon(Icons.add, size: 26),
                      onTap: () => imageRedactorBloc.add(
                        OnImageBrightnessIncrementEvent(state.brightness),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ActionButton(
                      icon: const Icon(Icons.remove, size: 26),
                      onTap: () => imageRedactorBloc.add(
                        OnImageHueDecrementEvent(state.hue),
                      ),
                    ),
                    const Text('Change hue of selected Image'),
                    ActionButton(
                      icon: const Icon(Icons.add, size: 26),
                      onTap: () => imageRedactorBloc.add(
                        OnImageHueIncrementEvent(state.hue),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ActionButton(
                      icon: const Icon(Icons.remove, size: 26),
                      onTap: () => imageRedactorBloc.add(
                        OnImageSaturationDecrementEvent(state.saturation),
                      ),
                    ),
                    const Text('Change saturation of selected Image'),
                    ActionButton(
                      icon: const Icon(Icons.add, size: 26),
                      onTap: () => imageRedactorBloc.add(
                        OnImageBrightnessIncrementEvent(state.saturation),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Double Tap to zoom/unzoom image',
                  style: TextStyle(fontSize: 14),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height / 2.50,
                    child: ChangeColors(
                      hue: state.hue,
                      brightness: state.brightness,
                      saturation: state.saturation,
                      child: PhotoView(
                        imageProvider: state.image != null
                            ? FileImage(File(state.image!.path))
                            : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          );
        } else {
          return const Center(
            child: Text('Image must be here'),
          );
        }
      },
    );
  }
}

class ImageRedactorFab extends StatelessWidget {
  const ImageRedactorFab({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageRedactorBloc imageRedactorBloc =
        context.read<ImageRedactorBloc>();

    return BlocBuilder<ImageRedactorBloc, ImageRedactorState>(
      builder: (context, state) {
        return state.image == null
            ? FloatingActionButton(
                child: const Center(
                  child: Icon(
                    Icons.add,
                    size: 30,
                  ),
                ),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) => RepaintBoundary(
                    child: Container(
                      height: MediaQuery.sizeOf(context).height / 6,
                      color: Colors.blueGrey,
                      child: Wrap(
                        children: [
                          ListTile(
                            leading: const Icon(
                              Icons.photo_library_rounded,
                              size: 24,
                            ),
                            title: const Text('Select Image from gallery'),
                            onTap: () {
                              imageRedactorBloc
                                  .add(PickImageFromGalleryEvent(state.image));
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons.camera_alt_rounded,
                              size: 24,
                            ),
                            title: const Text(
                              'Select Image from camera',
                            ),
                            onTap: () {
                              imageRedactorBloc.add(
                                PickImageFromCameraEvent(state.image),
                              );
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
