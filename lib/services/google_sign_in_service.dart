import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      serverClientId:
          "694357637063-4fc6a0gj07ddtpq4dvuka1tsq5md4a6s.apps.googleusercontent.com");

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    if (GetPlatform.isAndroid && GetPlatform.isIOS && GetPlatform.isWeb) {
      return await _googleSignIn.signIn();
    }

    return null;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
