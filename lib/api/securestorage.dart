import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = new FlutterSecureStorage();

  static const _keyToken = 'token';

  Future<void> save(String value) async {
    await storage.write(key: _keyToken, value: value);
  }

  Future<String?> read() async {
    return await storage.read(key: _keyToken);
  }

  Future<String?> readToken(String key) async {
    return await storage.read(key: _keyToken);
  }

  Future<void> delete() async {
    await storage.delete(key: _keyToken);
  }
}
