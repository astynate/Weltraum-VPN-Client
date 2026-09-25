import 'package:flutter/foundation.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

class MicrosoftLoginOperator {
  static const String clientId = 'c7a2e27a-eec2-4ec4-b49b-d04ba41b51d0';

  static const String redirectUri =
      'http://localhost:8000/oauth/callback';

  static Future<String?> login() async {
    try {
      final authUri = Uri.https(
        'login.microsoftonline.com',
        '/common/oauth2/v2.0/authorize',
        {
          'client_id': clientId,
          'redirect_uri': redirectUri,
          'response_type': 'code',
          'scope': 'openid profile email',
          'response_mode': 'query',
        },
      );

      debugPrint('Microsoft auth URL: $authUri');

      final result = await FlutterWebAuth2.authenticate(
        url: authUri.toString(),
        callbackUrlScheme: 'http://localhost:8000',
        options: const FlutterWebAuth2Options(
          useWebview: false,
        ),
      );

      debugPrint('Microsoft callback: $result');

      final callbackUri = Uri.parse(result);

      final error = callbackUri.queryParameters['error'];

      if (error != null) {
        final description =
            callbackUri.queryParameters['error_description'];

        throw Exception(
          'Microsoft OAuth error: $error'
          '${description != null ? ' - $description' : ''}',
        );
      }

      final code = callbackUri.queryParameters['code'];

      if (code == null || code.isEmpty) {
        throw Exception(
          'Microsoft did not return authorization code.\n'
          'Callback: $result',
        );
      }

      debugPrint('Microsoft authorization code: $code');

      return code;
    } catch (e, stackTrace) {
      debugPrint('Microsoft login error: $e');
      debugPrintStack(stackTrace: stackTrace);

      return null;
    }
  }
}