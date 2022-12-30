import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class _Keys {
  static const authToken = 'auth_token';
}

class AuthTokenDataProvider {
  static const _secureStorage = FlutterSecureStorage();

  Future<String?> getAuthToken() => _secureStorage.read(key: _Keys.authToken);
  // Future<String?> getAuthToken() => Future(() => null);

  Future<void> setAuthToken(String? token) {
    if (token != null) {
      return _secureStorage.write(key: _Keys.authToken, value: token);
    } else {
      return _secureStorage.delete(key: _Keys.authToken);
    }
  }
}
