import 'package:get_storage/get_storage.dart';

class OneLocalStorage {
  static final OneLocalStorage _instance = OneLocalStorage._internal();

  factory OneLocalStorage() {
    return _instance;
  }

  OneLocalStorage._internal();

  final _storage = GetStorage();

  //Generic method to save Data
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  //Generic method to read Data
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  //Generic method to remove Data
  Future<void> removeData<T>(String key) async {
    await _storage.remove(key);
  }

  //Generic method to clearAll Data
  Future<void> clearAll<T>() async {
    await _storage.erase();
  }
}
