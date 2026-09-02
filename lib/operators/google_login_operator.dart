import 'package:flutter_app/api/account_api.dart';
import 'package:flutter_app/classes/account/account.dart';
import 'package:flutter_app/classes/application/application_state.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginOperator {
  ApplicationState state;

  GoogleLoginOperator(this.state);

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '704264411166-0duu4t16pobdj0254d269toc8d6c8atp.apps.googleusercontent.com',
    scopes: ['email', 'profile'],
  );

  Future<bool> handleGoogleLogin() async {
    try {
      final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
      
      if (googleAccount == null) return false;

      final GoogleSignInAuthentication authentification = await googleAccount.authentication;
      
      dynamic result = await AccountAPI.authorizeWithGoogle(googleAccount.email, googleAccount.displayName ?? "Unknown User", googleAccount.photoUrl);

      if (result != null && result.accont != null && result.accessToken != null && result.refreshToken != null) {
        state.setAccount(result.account);
        state.saveTokens(result.accessToken, result.refreshToken);
      }

      return true;
    } catch (e) {
      print("Google login error: $e");
      return false;
    }
  }
}