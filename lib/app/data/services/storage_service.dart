import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class StorageService extends GetxService {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<StorageService> init() async {
    return this;
  }

  // Authentication Storage
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: 'access_token', value: token);
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: 'refresh_token', value: token);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

  Future<void> saveUserInfo(String id, String email, List<String> roles) async {
    await _storage.write(key: 'user_id', value: id);
    await _storage.write(key: 'user_email', value: email);
    await _storage.write(key: 'user_roles', value: roles.join(','));
  }

  Future<String?> getUserId() async {
    return await _storage.read(key: 'user_id');
  }

  Future<String?> getUserEmail() async {
    return await _storage.read(key: 'user_email');
  }

  Future<List<String>> getUserRoles() async {
    final roles = await _storage.read(key: 'user_roles');
    if (roles == null || roles.isEmpty) {
      return [];
    }
    return roles.split(',');
  }

  Future<void> clearAuthData() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
    await _storage.delete(key: 'user_id');
    await _storage.delete(key: 'user_email');
    await _storage.delete(key: 'user_roles');
  }

  // Theme and Preferences
  Future<void> saveThemeMode(String mode) async {
    await _storage.write(key: 'theme_mode', value: mode);
  }

  Future<String?> getThemeMode() async {
    return await _storage.read(key: 'theme_mode');
  }
}
