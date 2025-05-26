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

  Future<void> loginWithGoogle() async {
    isLoading(true);
    final GoogleSignInAccount? user =
        await _googleSignInService.signInWithGoogle();
    final GoogleSignInAuthentication auth = await user!.authentication;
    final idToken = auth.idToken;
    await _authApi.loginWithGoogle(idToken ?? "");
    isLoading(false);
  }
}
