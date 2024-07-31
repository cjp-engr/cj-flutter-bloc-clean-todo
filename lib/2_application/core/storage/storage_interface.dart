abstract class AppStorage {
  Future<bool> saveStringValue(String key, String value);
  Future<bool> saveDoubleValue(String key, double value);
  Future<bool> saveBoolValue(String key, bool value);
  Future<bool> removeData(String key);
  String? getStringValue(String key);
  double getDoubleValue(String key);
  bool? getBoolValue(String key);
}
