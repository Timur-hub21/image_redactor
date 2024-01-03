import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  final LocalAuthentication localAuthentication;
  LocalAuthService(this.localAuthentication);

  /// Get list of available biometrics
  Future<void> getBiometrics() async {
    List<BiometricType> biometrics =
        await localAuthentication.getAvailableBiometrics();
    debugPrint('Biometrics: $biometrics');
  }

  /// Authenticate method for biometric check
  Future<bool> localAuth() async {
    try {
      final bool authenticated = await localAuthentication.authenticate(
        localizedReason: 'Please provide your data',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      return authenticated;
    } on PlatformException catch (error) {
      debugPrint(error.toString());
    }
    return false;
  }
}
