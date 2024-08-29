import 'package:flutter/material.dart';
import 'package:smart_board_app/service/authentication_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthenticationService _authService = AuthenticationService();
  String? _token;
  String? get token => _token;

  Future<void> login(String phone, String code) async {
    try {
      final result = await _authService.login(phone, code);
      if (result['code'] == 200) {
        _token = result['data'];
        // Notify listeners for any UI updates
        notifyListeners();
      } else {
        // Handle login failure
        throw Exception('Login failed with code: ${result['code']}');
      }
    } catch (error) {
      // Handle any errors
      throw Exception('Login failed: $error');
    }
  }
}
