import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      serverClientId:
          "694357637063-4fc6a0gj07ddtpq4dvuka1tsq5md4a6s.apps.googleusercontent.com");

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    GoogleSignInAccount? user = await _googleSignIn.signIn();
    
    return user;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
