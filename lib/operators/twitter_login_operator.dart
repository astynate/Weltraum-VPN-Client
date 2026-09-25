import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';

class TwitterLoginOperator {
  static const String clientId = 'bGtjdDkyUnVHcnpyQjc4UFEwSmM6MTpjaQ';

  static const String redirectUri = 'http://localhost:8000/oauth/callback';

  static Future<String?> login() async {
    try {
      final codeVerifier = _generateCodeVerifier();
      final codeChallenge = _generateCodeChallenge(codeVerifier);
      final state = _generateState();

      final authUri = Uri.https(
        'twitter.com',
        '/i/oauth2/authorize',
        {
          'response_type': 'code',
          'client_id': clientId,
          // 'redirect_uri': redirectUri,
          'scope': 'users.read',
          'state': state,
          'code_challenge': codeChallenge,
          'code_challenge_method': 'S256',
        },
      );

      debugPrint('X OAuth URL: $authUri');

      final result = await FlutterWebAuth2.authenticate(
        url: authUri.toString(),
        callbackUrlScheme: 'myapp',

        options: const FlutterWebAuth2Options(
          useWebview: false,
        ),
      );

      debugPrint('X callback: $result');

      final callbackUri = Uri.parse(result);
      final error = callbackUri.queryParameters['error'];

      if (error != null) {
        final description =
            callbackUri.queryParameters['error_description'];

        throw Exception(
          'X OAuth error: $error'
          '${description != null ? ' - $description' : ''}',
        );
      }

      final returnedState = callbackUri.queryParameters['state'];

      if (returnedState == null || returnedState != state) {
        throw Exception('Invalid OAuth state');
      }

      final code = callbackUri.queryParameters['code'];

      if (code == null || code.isEmpty) {
        throw Exception(
          'X did not return authorization code.\n'
          'Callback: $result',
        );
      }

      return jsonEncode({
        'code': code,
        'codeVerifier': codeVerifier,
        'redirectUri': redirectUri,
      });
    } catch (e, stackTrace) {
      debugPrint('X login error: $e');
      debugPrintStack(stackTrace: stackTrace);

      return null;
    }
  }

  static String _generateCodeVerifier() {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
        'abcdefghijklmnopqrstuvwxyz'
        '0123456789-._~';

    final random = Random.secure();

    return List.generate(
      64,
      (_) => chars[random.nextInt(chars.length)],
    ).join();
  }

  static String _generateCodeChallenge(String verifier) {
    final bytes = utf8.encode(verifier);
    final digest = sha256.convert(bytes);

    return _base64UrlEncode(digest.bytes);
  }

  static String _generateState() {
    final random = Random.secure();

    final bytes = List<int>.generate(
      32,
      (_) => random.nextInt(256),
    );

    return _base64UrlEncode(bytes);
  }

  static String _base64UrlEncode(List<int> bytes) {
    return base64UrlEncode(bytes).replaceAll('=', '');
  }
}