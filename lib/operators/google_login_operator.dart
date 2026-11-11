import 'dart:async';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:weltraum/api/account_api.dart';
import 'package:weltraum/classes/account/account.dart';
import 'package:weltraum/classes/application/application_state.dart';
import 'package:google_sign_in_all_platforms/google_sign_in_all_platforms.dart';

class GoogleLoginOperator {
  ApplicationState state;

  GoogleLoginOperator(this.state);

  static final GoogleSignIn instance = GoogleSignIn(
    params: const GoogleSignInParams(
      clientId: '704264411166-0duu4t16pobdj0254d269toc8d6c8atp.apps.googleusercontent.com',
      clientSecret: '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',
      redirectPort: 8000,
      scopes: [
        'openid',
        'profile',
        'email',
      ],
    ),
  );

  Future<bool> handleGoogleLogin() async {
    try {
      await instance.signOut();

      final credentials = await instance.signIn();

      if (credentials == null) {
        return false;
      }

      if (credentials.idToken != null) {
        var loginResult = await AccountAPI.authorizeWithExternalID(credentials.idToken ?? "", "google");

        if (loginResult.$1 != null) {
          state.login(
            loginResult.$1 as Account, 
            loginResult.$2 as String, 
            loginResult.$3 as String
          );
        }
      }

      return true;
    } catch (e) {
      print("Google login error: $e");
      return false;
    }
  }
}