import 'dart:convert';

import 'package:grocery_app/core/constants.dart';
import 'package:grocery_app/models/user.dart';
import 'package:grocery_app/services/storages/token_storage.dart';
import 'package:grocery_app/utils/api_headers.dart';
import 'package:http/http.dart' as http;

class UserApi {
  final TokenStorage _storage = TokenStorage();

  Future<User> getProfile() async {
    try {
      final token = await _storage.getToken();
      final url = Uri.parse("${AppConstants.baseUrl}/users/profile");
      final response = await http.get(url, headers: headers(token!));
      if (response.statusCode == 200) {
        final userJson = jsonDecode(response.body) as Map<String, dynamic>;
        return User.fromJson(userJson);
      } else {
        return User.empty();
      }
    } catch (e) {
      return User.empty();
    }
  }
}
