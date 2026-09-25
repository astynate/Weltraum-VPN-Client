import 'dart:async';
// import 'package:google_sign_in/google_sign_in.dart';
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
      final credentials = await instance.signIn();

      if (credentials == null) {
        return false;
      }

      print('credentials: $credentials');
      print('accessToken: ${credentials?.accessToken}');
      print('idToken: ${credentials?.idToken}');
      print('refreshToken: ${credentials?.refreshToken}');

      // credentials.

      return true;
    } catch (e) {
      print("Google login error: $e");
      return false;
    }
  }
}