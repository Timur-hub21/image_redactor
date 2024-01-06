import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_redactor/bloc/image_redactor_bloc/image_redactor_bloc.dart';
import 'package:image_redactor/bloc/image_redactor_bloc/image_redactor_event.dart';
import 'package:image_redactor/bloc/image_redactor_bloc/image_redactor_state.dart';

class ImageRedactorScreen extends StatelessWidget {
  const ImageRedactorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageRedactorBloc imageRedactorBloc =
        context.read<ImageRedactorBloc>();

    return BlocConsumer<ImageRedactorBloc, ImageRedactorState>(
      listener: (BuildContext context, ImageRedactorState state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: const SafeArea(
            child: ImageRedactorBody(),
          ),
          floatingActionButton: FloatingActionButton(
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
                          imageRedactorBloc
                              .add(PickImageFromCameraEvent(state.image));
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ImageRedactorBody extends StatelessWidget {
  const ImageRedactorBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageRedactorBloc, ImageRedactorState>(
      builder: (context, state) {
        if (state is ImageRedactorLoadingState) {
          return const Center(child: Text('Loading...'));
        } else if (state is ImagePickedState) {
          return Center(child: Image.file(File(state.image!.path)));
        } else {
          return const Center(child: Text('Image must be here'));
        }
      },
    );
  }
}
