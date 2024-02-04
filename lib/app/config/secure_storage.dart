import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  salvar(String key, String valor) async {
    await storage.write(key: key, value: valor);
  }

  Future<String> ler(String key) async {
    return await storage.read(key: key) ?? '';
  }

  apagar(String key) async {
    await storage.delete(key: key);
  }
}
