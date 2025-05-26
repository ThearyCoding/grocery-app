import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      serverClientId:
          "694357637063-coja2m3sk28e6e0sidbhbjvm2621icpl.apps.googleusercontent.com");

  Future<GoogleSignInAccount?> signInWithGoogle() async {
    GoogleSignInAccount? user = await _googleSignIn.signIn();
    
    return user;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
