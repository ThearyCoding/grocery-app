import 'dart:io';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_app/services/apis/auth_api.dart';
import 'package:grocery_app/services/google_sign_in_service.dart';

import '../services/storages/token_storage.dart';

class AuthController extends GetxController {
  final AuthApi _authApi = AuthApi();
  final TokenStorage _tokenStorage = TokenStorage();
  final GoogleSignInService _googleSignInService = GoogleSignInService();
  final isLoading = false.obs;
  Future<void> login(String email, String password) async {
    isLoading(true);
    await _authApi.login(email, password);
    isLoading(false);
  }

  Future<void> register(String fullName, String email, String password) async {
    isLoading(true);
    await _authApi.register(fullName, email, password);
    isLoading(false);
  }

  Future<void> logOut() async {
    if (Platform.isWindows == false) {
      await _googleSignInService.signOut();
    }
    await _tokenStorage.clearToken();
  }

  Future<bool> loginWithGoogle() async {
    if (GetPlatform.isMobile || GetPlatform.isWeb) {
      try {
        isLoading(true);

        final GoogleSignInAccount? user =
            await _googleSignInService.signInWithGoogle();

        if (user == null) {
          Get.snackbar("Login Cancelled", "User cancelled Google Sign-In.");
          return false;
        }

        final GoogleSignInAuthentication auth = await user.authentication;
        final idToken = auth.idToken;

        if (idToken == null) {
          Get.snackbar("Login Failed", "Google token is null.");
          return false;
        }

        await _authApi.loginWithGoogle(idToken);
        return true;
      } catch (e) {
        Get.snackbar("Login Error", e.toString());
        return false;
      } finally {
        isLoading(false);
      }
    } else {
      String platformName = GetPlatform.isLinux
          ? "Linux"
          : GetPlatform.isWindows
              ? "Windows"
              : "This platform";

      Get.snackbar("Error", "$platformName is not supported for Google Login.");
      return false;
    }
  }
}
