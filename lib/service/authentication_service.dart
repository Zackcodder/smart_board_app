
import 'dart:convert';

import 'package:http/http.dart' as http;
class AuthenticationService {

  final String baseUrl = "http://39.108.223.110:9199";

  Future<Map<String, dynamic>> login(String phone, String code) async {
    final url = Uri.parse('$baseUrl/user/tbuser/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'phone': phone,
        'code': code,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }
}