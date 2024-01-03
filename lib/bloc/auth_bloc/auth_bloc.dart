// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_redactor/bloc/auth_bloc/auth_event.dart';
import 'package:image_redactor/bloc/auth_bloc/auth_state.dart';
import 'package:image_redactor/implementations/auth_repository_impl.dart';
import 'package:image_redactor/utils/auth_status.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepositoryImplementation _authRepositoryImplementation;

  AuthBloc({required AuthRepositoryImplementation authRepositoryImplementation})
      : _authRepositoryImplementation = authRepositoryImplementation,
        super(AuthStateInitial()) {
    on<GetBiometricsTypeEvent>(_getBiometrics);

    on<AuthStatusChangedByLocalAuthEvent>(_localAuth);
  }

  Future<void> _getBiometrics(
    GetBiometricsTypeEvent biometricsTypeEvent,
    Emitter<AuthState> emitter,
  ) async {
    return _authRepositoryImplementation.getBiometrics();
  }

  Future<void> _localAuth(
    AuthStatusChangedByLocalAuthEvent authStatusChangedByLocalAuthEvent,
    Emitter<AuthState> emitter,
  ) async {
    final bool authenticated = await _authRepositoryImplementation.localAuth();

    if (authenticated == true) {
      Future.delayed(const Duration(seconds: 1));
      emit(AuthStateAuthenticated(status: AuthStatus.authenticated));
    }
  }
}
