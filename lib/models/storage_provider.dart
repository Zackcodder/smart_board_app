import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageProvider with ChangeNotifier {
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    notifyListeners();
  }

  List<Map<String, dynamic>> all(String key) {
    final data = _prefs?.getString(key) ?? '[]';
    return List<Map<String, dynamic>>.from(json.decode(data));
  }

  Map<String, dynamic>? index(String key, String id) {
    final data = all(key);
    return data.firstWhere((item) => item['id'] == id, orElse: () => {});
  }

  void set(String key, List<Map<String, dynamic>> data) {
    _prefs?.setString(key, json.encode(data));
    notifyListeners();
  }

  void clear(String key) {
    _prefs?.remove(key);
    notifyListeners();
  }
}
