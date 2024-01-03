import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_redactor/bloc/auth_bloc/auth_bloc.dart';
import 'package:image_redactor/implementations/auth_repository_impl.dart';
import 'package:image_redactor/screens/main_screen.dart';
import 'package:image_redactor/services/local_auth_service.dart';
import 'package:local_auth/local_auth.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  late final AuthRepositoryImplementation _authRepositoryImplementation;
  late final LocalAuthentication _localAuthentication;
  late final LocalAuthService _localAuthService;

  @override
  void initState() {
    super.initState();
    _localAuthentication = LocalAuthentication();
    _localAuthService = LocalAuthService(_localAuthentication);
    _authRepositoryImplementation =
        AuthRepositoryImplementation(_localAuthService);
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
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Image Redactor',
        home: MainScreen(),
      ),
    );
  }
}
