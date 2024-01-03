import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

final class GetBiometricsTypeEvent extends AuthEvent {
  final List<BiometricType> biometrics;
  const GetBiometricsTypeEvent(this.biometrics);
}

final class AuthStatusChangedByLocalAuthEvent extends AuthEvent {
  const AuthStatusChangedByLocalAuthEvent();
}
