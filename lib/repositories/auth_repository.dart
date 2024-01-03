/// Repository for auth methods
abstract interface class AuthRepository {
  Future<void> getBiometrics() async {}

  Future<bool?> localAuth() async {
    return null;
  }
}
