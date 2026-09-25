import 'package:flutter/foundation.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

class FacebookLoginOperator {
  static const String clientId = '28347603804898155';
  static const String redirectUri ='http://localhost:8000/oauth/callback';

  static Future<String?> login() async {
    try {
      final authUri = Uri.https(
        'www.facebook.com',
        '/v23.0/dialog/oauth',
        {
          'client_id': clientId,
          'redirect_uri': redirectUri,
          'scope': 'public_profile',
          'response_type': 'code',
        },
      );

      final result = await FlutterWebAuth2.authenticate(
        url: authUri.toString(),
        callbackUrlScheme: 'http://localhost:8000',
        options: const FlutterWebAuth2Options(
          useWebview: false,
        ),
      );

      debugPrint('Facebook callback: $result');

      final callbackUri = Uri.parse(result);

      final error = callbackUri.queryParameters['error'];

      if (error != null) {
        final description =
            callbackUri.queryParameters['error_description'];

        throw Exception(
          'Facebook OAuth error: $error'
          '${description != null ? ' - $description' : ''}',
        );
      }

      final code = callbackUri.queryParameters['code'];

      if (code == null || code.isEmpty) {
        throw Exception(
          'Facebook did not return authorization code.\n'
          'Callback: $result',
        );
      }

      return code;
    } catch (e, stackTrace) {
      debugPrint('Facebook login error: $e');
      debugPrintStack(stackTrace: stackTrace);

      return null;
    }
  }
}