abstract class ICustomAppStorage {
  Future<void> saveKey(String key, dynamic value);
  Future<void> saveKeyMap(Map<String, dynamic> map);
  Future<void> removeKey(String key);
  Future<dynamic> readKey(String key);
  Future<Map<String, String>> getAllKeys();
  Future<void> deleteAllKeys();
}
