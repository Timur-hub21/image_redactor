import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:image_redactor/utils/auth_status.dart';

@immutable
abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthStateInitial extends AuthState {
  final AuthStatus status;
  AuthStateInitial({this.status = AuthStatus.unknown});

  @override
  List<Object> get props => [status];
}

class AuthStateAuthenticated extends AuthState {
  final AuthStatus status;
  AuthStateAuthenticated({this.status = AuthStatus.authenticated});

  @override
  List<Object> get props => [status];
}

class AuthStateUnauthenticated extends AuthState {
  final AuthStatus status;
  AuthStateUnauthenticated({this.status = AuthStatus.unauthenticated});

  @override
  List<Object> get props => [status];
}
