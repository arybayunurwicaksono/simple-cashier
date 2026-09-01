import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/storage_keys.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(
                encryptedSharedPreferences: true,
              ),
              iOptions: IOSOptions(
                accessibility: KeychainAccessibility.first_unlock,
              ),
            );

  Future<void> saveUserSession({
    required int userId,
    required String username,
    required String email,
    required String role,
    String? token,
  }) async {
    await _storage.write(key: StorageKeys.keyActiveUserId, value: userId.toString());
    await _storage.write(key: StorageKeys.keyActiveUsername, value: username);
    await _storage.write(key: StorageKeys.keyActiveUserEmail, value: email);
    await _storage.write(key: StorageKeys.keyActiveUserRole, value: role);
    await _storage.write(key: StorageKeys.keyIsLoggedIn, value: 'true');
    if (token != null) {
      await _storage.write(key: StorageKeys.keyAuthToken, value: token);
    }
  }

  Future<int?> getActiveUserId() async {
    final val = await _storage.read(key: StorageKeys.keyActiveUserId);
    return val != null ? int.tryParse(val) : null;
  }

  Future<String?> getActiveUsername() async {
    return _storage.read(key: StorageKeys.keyActiveUsername);
  }

  Future<String?> getActiveUserEmail() async {
    return _storage.read(key: StorageKeys.keyActiveUserEmail);
  }

  Future<String?> getActiveUserRole() async {
    return _storage.read(key: StorageKeys.keyActiveUserRole);
  }

  Future<bool> isLoggedIn() async {
    final val = await _storage.read(key: StorageKeys.keyIsLoggedIn);
    return val == 'true';
  }

  Future<String?> getAuthToken() async {
    return _storage.read(key: StorageKeys.keyAuthToken);
  }

  Future<void> clearSession() async {
    await _storage.delete(key: StorageKeys.keyActiveUserId);
    await _storage.delete(key: StorageKeys.keyActiveUsername);
    await _storage.delete(key: StorageKeys.keyActiveUserEmail);
    await _storage.delete(key: StorageKeys.keyActiveUserRole);
    await _storage.delete(key: StorageKeys.keyIsLoggedIn);
    await _storage.delete(key: StorageKeys.keyAuthToken);
    await _storage.delete(key: StorageKeys.keyRefreshToken);
  }
}
