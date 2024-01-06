import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_redactor/bloc/auth_bloc/auth_bloc.dart';
import 'package:image_redactor/bloc/image_redactor_bloc/image_redactor_bloc.dart';
import 'package:image_redactor/implementations/auth_repository_impl.dart';
import 'package:image_redactor/implementations/image_redactor_impl.dart';
import 'package:image_redactor/screens/image_redactor_screen.dart';
import 'package:image_redactor/screens/loca_auth_screen.dart';
import 'package:image_redactor/services/image_picker_service.dart';
import 'package:image_redactor/services/local_auth_service.dart';
import 'package:local_auth/local_auth.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  static late final AuthRepositoryImplementation _authRepositoryImplementation;
  static late final LocalAuthentication _localAuthentication;
  static late final LocalAuthService _localAuthService;
  static late final ImagePickerService _imagePickerService;
  static late final ImageRedactorImplementation _imageRedactorImplementation;

  @override
  void initState() {
    super.initState();
    _localAuthentication = LocalAuthentication();
    _localAuthService = LocalAuthService(_localAuthentication);
    _imagePickerService = ImagePickerService();
    _authRepositoryImplementation =
        AuthRepositoryImplementation(_localAuthService);
    _imageRedactorImplementation =
        ImageRedactorImplementation(_imagePickerService);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(
            authRepositoryImplementation: _authRepositoryImplementation,
          ),
        ),
        BlocProvider<ImageRedactorBloc>(
          create: (BuildContext context) => ImageRedactorBloc(
            imageRedactorImplementation: _imageRedactorImplementation,
          ),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Image Redactor',
        home: ImageRedactorScreen(),
      ),
    );
  }
}
