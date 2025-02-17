import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveApiKey(String apiKey) async {
    await _storage.write(key: 'openai_api_key', value: apiKey);
  }

  static Future<String?> getApiKey() async {
    return await _storage.read(key: 'openai_api_key');
  }

  static Future<void> deleteApiKey() async {
    await _storage.delete(key: 'openai_api_key');
  }
}
