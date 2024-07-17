import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: dotenv.get('ACCESS_TOKEN_KEY'), value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: dotenv.get('ACCESS_TOKEN_KEY'));
  }
}

TokenStorage tokenStorage = TokenStorage();
