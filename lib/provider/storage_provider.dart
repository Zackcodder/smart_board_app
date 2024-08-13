import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class StorageProvider with ChangeNotifier {
  static final GetStorage _box = GetStorage();

  Future<void> init() async {
    await GetStorage.init();
    notifyListeners();
  }

  dynamic get(String key, [Function(Map)? transformer]) {
    dynamic data = _box.read(key);

    if (transformer != null && data != null) {
      return transformer(data);
    } else {
      return data;
    }
  }

  dynamic index(String key, dynamic id) {
    return _box.read(key).firstWhere((e) => e['id'] == id);
  }

  List<dynamic> all(String key, Function(Map) transformer) {
    return (_box.read(key) ?? []).map((e) => transformer(e)).toList();
  }

  void store(Map data, [Function? transformer]) {
    data.forEach((key, value) {
      _box.write(key, transformer != null ? transformer(value) : value);
    });
    notifyListeners();
  }

  void create(String key, Map data) {
    List modified = _box.read(key) ?? [];
    modified.add(data);
    _box.write(key, modified);
    notifyListeners();
  }

  void set(String key, dynamic value) {
    _box.write(key, value);
    notifyListeners();
  }

  void update(String key, int id, Map data) {
    List modified = _box.read(key) ?? [];
    int index = modified.indexWhere((e) => e['id'] == id);
    modified[index] = data;
    _box.write(key, modified);
    notifyListeners();
  }

  void delete(String key, int id) {
    List modified = _box.read(key) ?? [];
    modified.removeWhere((e) => e['id'] == id);
    _box.write(key, modified);
    notifyListeners();
  }

  void clear() {
    _box.erase();
    notifyListeners();
  }
}
