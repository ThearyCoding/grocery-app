import 'dart:convert';
import 'package:grocery_app/core/constants.dart';
import 'package:grocery_app/services/storages/token_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;
import 'package:get/get.dart';

import '../../pages/main_page.dart';

class AuthApi {
  final _tokenStorage = TokenStorage();
  Future<void> login(String email, String password) async {
    try {
      final url = Uri.parse("${AppConstants.baseUrl}/users/login");
      final response = await http.post(
          headers: {"Content-Type": "application/json"},
          url,
          body: jsonEncode({"email": email, "password": password}));
      if (response.statusCode == 201) {
        final token = jsonDecode(response.body)['token'];
        await _tokenStorage.setToken(token);
        Get.snackbar("Sucess", "Login success.");
        Get.off(() => MainPage());
      } else {
        Get.snackbar("Error", "Error loging with email and password.");
      }
    } catch (e) {
      dev.log("error login: $e");
    }
  }

  Future<void> register(String fullName, String email, String password) async {
    try {
      final url = Uri.parse("${AppConstants.baseUrl}/users/register");
      final response = await http.post(
          headers: {"Content-Type": "application/json"},
          url,
          body: jsonEncode(
              {"email": email, "password": password, "fullName": fullName}));
      if (response.statusCode == 201) {
        final token = jsonDecode(response.body)['token'];
        await _tokenStorage.setToken(token);
        Get.snackbar("Sucess", "Login success.");
        Get.off(() => MainPage());
      } else {
        Get.snackbar("Error", "Error loging with email and password.");
      }
    } catch (e) {
      dev.log("error login: $e");
    }
  }

  Future<void> loginWithGoogle(String idToken) async {
    try {
      
      final url = Uri.parse("${AppConstants.baseUrl}/auth/google-Signin");
      final response = await http.post(
          headers: {"Content-Type": "application/json"},
          url,
          body: jsonEncode({
            "idToken": idToken,
          }));
      dev.log("idToken: $idToken");
      if (response.statusCode == 201) {
        final token = jsonDecode(response.body)['token'];
        await _tokenStorage.setToken(token);
        Get.snackbar("Sucess", "Login success.");
      } else {
        Get.snackbar("Error", "Error loging with google");
      }
    } catch (e) {
      dev.log("Error login: $e");
    }
  }
}
