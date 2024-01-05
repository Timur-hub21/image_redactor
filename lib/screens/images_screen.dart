import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_redactor/bloc/image_redactor_bloc/image_redactor_bloc.dart';
import 'package:image_redactor/bloc/image_redactor_bloc/image_redactor_event.dart';
import 'package:image_redactor/bloc/image_redactor_bloc/image_redactor_state.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageRedactorBloc imageRedactorBloc =
        context.read<ImageRedactorBloc>();

    return BlocConsumer<ImageRedactorBloc, ImageRedactorState>(
      listener: (BuildContext context, ImageRedactorState state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Center(
              child: state.image != null
                  ? Image.file(File(state.image!.path))
                  : const Text('Image must be here'),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (BuildContext context) => RepaintBoundary(
                child: Container(
                  height: MediaQuery.sizeOf(context).height / 4.25,
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
