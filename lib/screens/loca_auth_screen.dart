import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_redactor/bloc/auth_bloc/auth_bloc.dart';
import 'package:image_redactor/bloc/auth_bloc/auth_event.dart';
import 'package:image_redactor/bloc/auth_bloc/auth_state.dart';
import 'package:image_redactor/implementations/auth_repository_impl.dart';
import 'package:image_redactor/screens/images_screen.dart';
import 'package:image_redactor/services/local_auth_service.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthScreen extends StatefulWidget {
  const LocalAuthScreen({super.key});

  @override
  State<LocalAuthScreen> createState() => _LocalAuthScreenState();
}

class _LocalAuthScreenState extends State<LocalAuthScreen> {
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
    AuthBloc(authRepositoryImplementation: _authRepositoryImplementation)
        .add(const GetBiometricsTypeEvent([]));
  }

  @override
  Widget build(BuildContext context) {
    final AuthBloc authBloc = context.read<AuthBloc>();

    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateAuthenticated) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ImagesScreen(),
              ),
            );
          } else if (state is AuthStateUnauthenticated) {
            SnackBar snackBar = SnackBar(
              content: Text(
                "Status: $state",
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              backgroundColor: Colors.black,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          return Center(
            child: ElevatedButton(
              child: const Text('Authenticate with local auth'),
              onPressed: () {
                authBloc.add(
                  const AuthStatusChangedByLocalAuthEvent(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
