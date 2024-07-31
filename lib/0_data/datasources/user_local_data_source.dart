import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/2_application/core/storage/secure_storage.dart';

abstract class LocalUserDataSource {
  Future<String> getUserAccessToken();
  Future<void> deleteUserAccessToken();
  Future<void> saveUserToken(String token);
}

class LocalUserDataSourceImpl implements LocalUserDataSource {
  LocalUserDataSourceImpl(this.flutterSecureStorage);

  final FlutterSecureStorage flutterSecureStorage;

  @override
  Future<void> saveUserToken(String token) async {
    flutterSecureStorage.write(
        key: SecureStorageKeys.accessToken, value: token);
  }

  @override
  Future<String> getUserAccessToken() async {
    return await flutterSecureStorage.read(
            key: SecureStorageKeys.accessToken) ??
        '';
  }

  @override
  Future<void> deleteUserAccessToken() {
    return flutterSecureStorage.delete(key: SecureStorageKeys.accessToken);
  }
}
