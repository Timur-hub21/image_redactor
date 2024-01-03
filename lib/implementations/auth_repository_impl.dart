import 'package:image_redactor/repositories/auth_repository.dart';
import 'package:image_redactor/services/local_auth_service.dart';

/// Implementation of AuthRepository methods
class AuthRepositoryImplementation implements AuthRepository {
  final LocalAuthService localAuthService;
  AuthRepositoryImplementation(this.localAuthService);

  @override
  Future<void> getBiometrics() async => localAuthService.getBiometrics();

  @override
  Future<bool> localAuth() async {
    final bool authenticated = await localAuthService.localAuth();
    return authenticated;
  }
}
