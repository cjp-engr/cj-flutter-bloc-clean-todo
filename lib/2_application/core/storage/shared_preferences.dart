import 'package:shared_preferences/shared_preferences.dart';

import 'package:frontend/2_application/core/storage/storage_interface.dart';

class SharedPreferenceService implements AppStorage {
  final SharedPreferences instance;
  SharedPreferenceService({
    required this.instance,
  });

  @override
  bool? getBoolValue(String key) {
    return instance.getBool(key);
  }

  @override
  double getDoubleValue(String key) {
    return instance.getDouble(key) ?? 0.0;
  }

  @override
  String? getStringValue(String key) {
    return instance.getString(key);
  }

  @override
  Future<bool> removeData(String key) {
    return instance.remove(key);
  }

  @override
  Future<bool> saveBoolValue(String key, bool value) {
    return instance.setBool(key, value);
  }

  @override
  Future<bool> saveDoubleValue(String key, double value) {
    return instance.setDouble(key, value);
  }

  @override
  Future<bool> saveStringValue(String key, String value) {
    return instance.setString(key, value);
  }
}
