import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const String accessTokenKey = "ACCESS_TOKEN_KEY";

class TokenStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: accessTokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: accessTokenKey);
  }
}

TokenStorage tokenStorage = TokenStorage();
