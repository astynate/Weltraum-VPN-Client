import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleLoginOperator {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '704264411166-0duu4t16pobdj0254d269toc8d6c8atp.apps.googleusercontent.com',
    scopes: ['email', 'profile'],
  );

  Future<void> handleGoogleLogin() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account == null) return;

      final GoogleSignInAuthentication auth = await account.authentication;
      // final idToken = auth.idToken;

      // print(idToken);
      print(account.displayName);
      print(account.email);
      print(account.photoUrl);

      // final response = await http.post(
      //   Uri.parse("https://YOUR_API_URL/api/auth/google"),
      //   headers: {"Content-Type": "application/json"},
      //   body: '{"idToken":"$idToken"}',
      // );

      // print("Backend response: ${response.body}");
    } catch (e) {
      print("Google login error: $e");
    }
  }
}