import 'dart:async';
import 'package:weltraum/api/account_api.dart';
import 'package:weltraum/classes/application/application_state.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginOperator {
  ApplicationState state;
  bool isInitialized = false;

  GoogleLoginOperator(this.state);

  Future<void> initialize() async {
      await _googleSignIn.initialize(
        clientId: '704264411166-0duu4t16pobdj0254d269toc8d6c8atp.apps.googleusercontent.com',
      );

      isInitialized = true;
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;


  Future<bool> handleGoogleLogin() async {
    try {
      if (isInitialized = false) {
        await initialize();
      }

      final GoogleSignInAccount googleAccount = await _googleSignIn.authenticate();
      
      dynamic result = await AccountAPI
        .authorizeWithGoogle(googleAccount.email, googleAccount.displayName ?? "Unknown User", googleAccount.photoUrl);

      if (result != null && result.account != null && result.accessToken != null && result.refreshToken != null) {
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